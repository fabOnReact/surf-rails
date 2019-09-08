class Location < ApplicationRecord
  has_many :posts
  has_one :forecast
  # after_validation :reverse_geocode, if: ->(obj){ valid_coordinates(obj) }

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    geo = results.first
    if geo && geo.data["error"].nil?
      obj.address = geo.address
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
    "https://maps.googleapis.com/maps/api/staticmap?center=#{gpsString}&zoom=11&markers=#{gpsString}&key=#{ENV['GOOGLE_MAPS_API_KEY']}&size=1200x1200&maptype=satellite"
  end

  def weekly_cron_tab
    next_day = DateTime.now.wday + 3
    next_day -= 6 if next_day > 6
    "0 0 * * #{DateTime.now.wday},#{next_day}"
  end

  def set_job
    Sidekiq::Cron::Job.load_from_array(
      [
        {
          name: "Location name: #{self.name}, id: #{self.id} - update forecast data - every 3 days at 00:00",
          id: "Location name: #{self.name}, id: #{self.id} - update forecast data - every 3 days at 00:00",
          cron: weekly_cron_tab,
          class: 'WeeklyForecastWorker',
          args: { id: id }
        },
        {
          name: "Location name: #{self.name}, id: #{self.id} - update forecast data - every day at 01:00",
          id: "Location name: #{self.name}, id: #{self.id} - update forecast data - every day at 01:00",
          cron: "0 1 * * *",
          class: 'DailyForecastWorker',
          args: { id: id }
        },
        {
          name: "Location name: #{self.name}, id: #{self.id} - update hourly forecast data - every hour at 00:00",
          id: "Location name: #{self.name}, id: #{self.id} - update hourly forecast data - every hour at 00:00",
          cron: "0 * * * *",
          class: 'HourlyForecastWorker',
          args: { id: id }
        },
      ]
    )
    DailyForecastWorker.perform_async({ id: self.id })
  end
end
