class Location < ApplicationRecord
  Integer.include(Integer::Transformations)
  has_many :cameras
  has_many :posts, through: :cameras
  has_one :forecast
  before_save :set_last_camera_at
  # after_validation :reverse_geocode, if: ->(obj){ valid_coordinates(obj) }
  scope :with_posts, -> { includes(cameras: :posts).where(cameras: { posts: { flagged: false }}) }
  scope :newest, -> { order(last_camera_at: :desc) }
  scope :newest_cameras, -> { order('cameras.last_post_at DESC') }
  scope :newest_posts, -> { order('posts.created_at DESC') }

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    geo = results.first
    if geo && geo.data["error"].nil?
      obj.address = geo.address
    end
  end

  def set_last_camera_at
    self.last_camera_at = DateTime.now
  end

  def with_current_forecast?
    forecast.present? && forecast.weather.current.present?
  end

  def get_hourly 
    forecast.weather.hourly.merge(optimal_conditions)
  end

  def optimal_conditions
    { "optimal_swell" => optimal_swell?, "optimal_wind" => optimal_wind? }
  end

  # def optimal_swell? def optimal_wind?
  %w(wind swell).each do |method|
    define_method("optimal_#{method}?".to_sym) do
      best_condition = send("best_#{method}_direction".to_sym)
      direction = forecast.weather.send("#{method}DirectionInWord".to_sym)
      best_condition.include? direction if best_condition
    end
  end

  # def optimal_swell?(swell) def optimal_wind?(wind)
  %w(wind swell).each do |field|
    # def optimal_swell(swell)
    define_method("optimal_#{field}?(#{field})".to_sym) do |param|
      best_condition = send("best_#{field}_direction".to_sym)
      best_condition.include? param if best_condition
    end
  end

  def optimal_forecast?
    @daily_forecast.map { |forecast| location.optimal_swell?(forecast) }
  end

  def get_daily
    daily = forecast.get_daily(week_days)
    %w(wind swell).each do |attr|
      daily["optimal_#{attr}"] = daily["#{attr}Direction"].map do |value|
        send("optimal_#{attr}?(#{attr})", value.in_word)
      end
    end
    daily
  end

  def week_days
    @week_days ||= (DateTime.now..DateTime.now + 6).map do |day|
      day.in_time_zone(timezone["timeZoneId"])
    end
  end

  def valid_coordinates(obj)
    obj.latitude.present? &&
    obj.longitude.present? &&
    obj.latitude.is_a?(Float) &&
    obj.longitude.is_a?(Float)
  end

  def distance_from_user(user_gps)
    Geocoder::Calculations.distance_between(user_gps, gps, units: :km).round(1)
  end

  def gps; [latitude, longitude]; end

  def offsetHours
    timezone["rawOffset"] / 3600
  end

  def google_map
    gpsString = gps.join(',')
    host = "https://maps.googleapis.com/maps/api/staticmap"
    center = "center=#{gpsString}"
    zoom = "zoom=11&markers=#{gpsString}"
    key = "key=#{ENV['GOOGLE_MAPS_API_KEY']}"
    size = "size=1200x1200"
    maptype = "maptype=satellite"
    "#{host}?#{center}&#{zoom}&#{key}&#{size}&#{maptype}"
  end

  def weekly_cron_tab
    first_day = @now.wday
    second_day = first_day.next_day
    "#{@now.minute} #{@now.hour - 1} * * #{first_day},#{second_day},#{second_day.next_day}"
  end

  def daily_cron_tab  
    "#{@now.minute} #{@now.hour} * * *"
  end

  def set_job
    @now = DateTime.now
    location_text = "Location name: #{self.name}, id: #{self.id}"
    Sidekiq::Cron::Job.load_from_array(
      [
        {
          name: "#{location_text} update forecast data - every 3 days",
          id: "#{location_text} update forecast data - every 3 days",
          cron: weekly_cron_tab,
          class: 'WeeklyForecastWorker',
          args: { id: id }
        },
        {
          name: "#{location_text} update forecast data - every day",
          id: "#{location_text} update forecast data - every day",
          cron: daily_cron_tab,
          class: 'DailyForecastWorker',
          args: { id: id }
        },
        {
          name: "#{location_text} update forecast data - every hour",
          id: "#{location_text} update forecast data - every hour",
          cron: "0 * * * *",
          class: 'HourlyForecastWorker',
          args: { id: id }
        },
      ]
    )
    DailyForecastWorker.perform_async({ id: self.id })
  end

  def storm
    @storm ||= Storm.new(latitude, longitude)
  end

  def maps
    @maps ||= Google::Maps.new(gps.join(','))
  end
end
