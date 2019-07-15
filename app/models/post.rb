require 'api/storm_glass'

class Post < ApplicationRecord
  include ActionView::Helpers::DateHelper

  scope :newest, -> { order(created_at: :desc) }

  belongs_to :user 
  belongs_to :location
  after_validation :reverse_geocode
  before_validation :set_additional_data
  after_create :set_cron_job
  attr_accessor :ip_code

  mount_uploader :picture, PictureUploader

  reverse_geocoded_by :latitude, :longitude do |obj, results| 
    geo = results.first
    if geo.present? && geo.data["error"].nil?
      obj.address = geo.address
      obj.city = geo.city if geo.city
    end
  end

  def set_additional_data
    api = StormGlass.new(latitude, longitude) 
    self.forecast = api.getWaveForecast
    self.location = Location.near([self.latitude, self.longitude], 50).first
  end

  def set_cron_job
    Sidekiq::Cron::Job.create(name: 'Post - update forecast data - every 24 hours', cron: '* 24 * *', class: 'PostWorker', args: self.id )
  end

  def liked(user_id)
    favorite.include? user_id
  end

  def creation_date
    "#{time_ago_in_words created_at} ago"
  end

  def utc_date
    created_at.utc
  end

  def owner?(owner)
    user == owner
  end

  def current_forecast
    forecast.select { |row| row["time"] == timeNow } if forecast.present?
  end

  def timeNow
    DateTime.now.utc.in_time_zone(-1).beginning_of_hour.xmlschema
  end
end
