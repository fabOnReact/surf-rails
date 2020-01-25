##### Table of Contents  
1. [Introduction](#introduction)  
2. [Forecast](#forecast)  
   a. [Retrieving Weather Forecast via Api](3#step-1-retrieving-information-via-api)  
   b. [Recording Cron Jobs](3#step-2-recording-cron-jobs)  
   c. [Calculating Surf Forecast](3#step-3-calculating-surf-forecast)

# Introduction
The `surf-rails` backend includes around 10.000 surfspots from **Europe**, **Oceania**, **Africa**, **America** and **Asia**, it's the first public api endpoint, currently the [magicseaweed api][6] does not provide this information.

<p align="center">
  <img src="https://portfoliofabrizio.s3.eu-central-1.amazonaws.com/surfcheck/europe.png" style="width:250px"/>
  <img src="https://portfoliofabrizio.s3.eu-central-1.amazonaws.com/surfcheck/australia.png" style="width:250px"/>
  <img src="https://portfoliofabrizio.s3.eu-central-1.amazonaws.com/surfcheck/africa.png" style="width:250px"/>
  <img src="https://portfoliofabrizio.s3.eu-central-1.amazonaws.com/surfcheck/NorthAmerica.png" style="width:250px"/>
  <img src="https://portfoliofabrizio.s3.eu-central-1.amazonaws.com/surfcheck/SouthAmerica.png" style="width:250px"/>
  <img src="https://portfoliofabrizio.s3.eu-central-1.amazonaws.com/surfcheck/asia.png" style="width:250px"/>
</p>

Each SurfSpot is represented as a [`location`][1] model in Ruby on Rails and it is [reverse geocoded][5] with the [`longitude`][4] and [`latitude`][4]. Each location includes information relative to the surf spot which are essential to calculate the surf forecast, for example [`best_wind_direction`][2] and [`best_swell_direction`][2] to display the green and red indicators in the mobile app. The *green*/*red* indicator represent [*wind*][10] or [*waves*][9] coming from *optimal*/*non-optimal* directions (*offshore* or *onshore*). 

<p align="center">
  <img src="https://portfoliofabrizio.s3.eu-central-1.amazonaws.com/surfcheck/WindDirection.png" style="width:250px"/>
</p>

The Mobile App retrieves the information through the [`/locations`][7] endpoint.
The [`/locations`][7] endpoint accepts three type of queries:
1) Locations filtered by `distance` from specific coordinates ([`#set_nearby_locations`][12]) 
2) Locations filtered within a [`bounding box`][11] ([`#set_locations_with_box`][13])
3) Locations that have videos of the surf conditions ([`#set_locations_with_cameras`][14])

More information and test cases are available in the `/locations` [api endpoint documentation][7].

The react native app retrieves from the `/locations` api endpoint the locations, forecast, videos information in the [`Locations`][15] `component` using the [`Api`][16] `class`. The information are retrieved at the application startup and cached. 
The same endpoint is used to display the different surfspots during map navigation with the [Map][17] `component` and the [Map][18] `class`.

<p align="center">
  <img src="https://portfoliofabrizio.s3.eu-central-1.amazonaws.com/surfcheck/map.png" style="width:250px"/>
  <img src="https://portfoliofabrizio.s3.eu-central-1.amazonaws.com/surfcheck/video.png" style="width:250px"/>
</p>

[1]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/app/models/location.rb
[2]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/db/schema.rb#L65
[3]: https://documenter.getpostman.com/view/6379421/SVfH1CeA?version=latest
[4]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/app/models/location.rb#L7
[5]: https://github.com/alexreisner/geocoder#geocoding-objects
[6]: https://magicseaweed.com/developer/api
[7]: https://documenter.getpostman.com/view/6379421/SVfH1CeA?version=latest#2e837949-2b59-4e00-911b-0cfd6173eda6
[9]: https://magicseaweed.com/help/forecast-table/swell
[10]: https://magicseaweed.com/help/forecast-table/wind
[11]: https://github.com/alexreisner/geocoder#advanced-database-queries
[12]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/app/controllers/locations_controller.rb#L36
[13]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/app/controllers/locations_controller.rb#L23
[14]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/app/controllers/locations_controller.rb#L28
[15]: https://github.com/fabriziobertoglio1987/surf-react-native/blob/master/app/components/index/Locations.js#L49
[16]: https://github.com/fabriziobertoglio1987/surf-react-native/blob/master/app/lib/api.js#L6
[17]: https://github.com/fabriziobertoglio1987/surf-react-native/blob/master/app/screens/MapScreen.js#L59
[18]: https://github.com/fabriziobertoglio1987/surf-react-native/blob/master/app/lib/map.js#L3

# Forecast 

The forecast information are retrieved from the stormglass api [endpoint][19] `/weather/point`. 
The application targets a specific country (Indonesia, Bali) with the plan and potential to expand to other areas in the world (inspired form the [following talk][20]). Forecast are retrieved only for locations featured in the landing page with at least one uploaded surfing video, limiting background jobs memory usage and video playback server expenses. 

The forecast are calculated with Sidekiq cron jobs. The [`#set_job`][21] method inside `Location` model starts the process which consist of the following steps:

#### STEP 1 Retrieving Information via Api

Runs the [`WeeklyForecastWorker`][22] to retrieve the forecast from the [api][19] and persist them in the [`Forecast`][23] model json `weather` column.

The [`#set_job`][21] method is called from the Location class.
```ruby
class Post < ApplicationRecord
  before_save :set_forecast
  def set_forecast
    location = self.camera.location
    location.set_job unless location.with_forecast
  end
end

class Location < ApplicationRecord
  def set_job
    # seeds for the first time the weather data
    WeeklyForecastWorker.perform_async({ id: self.id })
  end
end
```

Each `Location has_one :forecast`, the result of the [api call][19] is cached in the `weather` jsonb column for later postprocessing.

```ruby
class WeeklyForecastWorker
  include Sidekiq::Worker

  def perform(args)
    # calls execute_job
  end

  def execute_job
    return unless @location.storm.success?
    # saves the stormglass weather information in the database
    @location.forecast.update({ 
      weather: @location.storm.getWaves,
      tides: @location.storm.getTides,
    })
  end
end
```

#### STEP 2 Recording Cron Jobs
[Records a cron job][24] to repeat the [`WeeklyForecastWorker`][22] 3 times a week.

```ruby
class Location
  def weekly_cron_tab
    first_day = @now.wday
    second_day = first_day.next_day
    # returns a string for ex. 56 8 * * 4,6,2
    # to repeat the cron job 3 times a week
    # https://crontab.guru
    "#{@now.minute} #{@now.hour - 1} * * #{first_day},#{second_day},#{second_day.next_day}"
  end

  def set_job
    @now = DateTime.now
    location_text = "Location name: #{self.name}, id: #{self.id}"
    # Loads in Sidekiq the cron job
    Sidekiq::Cron::Job.load_from_array(
      [
        {
          name: "#{location_text} update forecast data - every 3 days",
          id: "#{location_text} update forecast data - every 3 days",
          cron: weekly_cron_tab,
          class: 'WeeklyForecastWorker',
          args: { id: id }
        },
      ]
    )
  end
end
```

#### STEP 3 Calculating Surf Forecast

Surf Forecast calculations are handled by the [`Weather`][25] plain ruby class.
The [`Weather`][25] class inherits from `Array` and it is used to parse the [`forecasts.weather`][19] jsonb column, calculates the hourly and daily average wave height, wave period, wind speed, wind direction...

```ruby
class Forecast < ApplicationRecord
  belongs_to :location

  # overwrites the default wether column attribute reader
  def weather
    # returns an instance of Weather class
    Weather.new(read_attribute(:weather) || [])
  end
end

Forecast.last.weather
=> [
      {
        "time"=>"2019-11-09T21:00:00+00:00",
        "seaLevel"=>[{"value"=>1.14, "source"=>"sg"}],
        "windSpeed"=>[{"value"=>10.14, "source"=>"sg"}, {"value"=>12.44, "source"=>"icon"}],
        "..." => "...",
      }, 
      {
        "time"=>"2019-11-09T22:00:00+00:00" 
      }
   ]
Forecast.last.weather.class
=> Weather
```

The [`Weather`][26] class [creates accessors][27] to retrieve informations from the json structure

```ruby
class Weather < Array
  # a symbol for each property to retrieve from the json response
  KEYS = %w(time swellHeight waveHeight windSpeed windDirection waveDirection 
  swellDirection swellPeriod)

  # generates def swellHeightRange get method
  # returns the current hour swellHeight as a range 
  # for example 1-5 (meters) of swell
  # 1 is the minimum for that hour and 5 is the maximum
  %w(swellHeight waveHeight windSpeed swellPeriod).each do |method|
    define_method("#{method}Range") { current[method].minMaxString }
  end

  # generates def waveHeights
  # returns an array of the current hour
  # wave heights based on different sources
  # for ex. [1,1.5,1,3]
  %w(waveHeight swellPeriod).each do |method|
    define_method(method.pluralize) do 
      current[method].collect { |x| x["value"] } 
    end
  end

  # generates def windDirectionInWord
  # based on a table of coordinates
  # returns the wave/swell direction in word
  %w(windDirection waveDirection swellDirection).each do |method|
    define_method("#{method}InWord".to_sym) { send(method.to_sym).in_word }
  end
end
```

[19]: https://docs.stormglass.io/#point-request
[20]: https://www.youtube.com/watch?v=xFFs9UgOAlE&t=1993s?t=265
[21]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/app/models/location.rb#L106
[22]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/app/workers/weekly_forecast_worker.rb
[23]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/app/models/forecast.rb
[24]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/app/models/location.rb#L111-L117
[25]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/app/models/forecast.rb#L11-L13
[26]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/lib/weather.rb#L3
[27]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/lib/weather.rb#L15-L27

[100]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/
[100]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/
[100]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/
[100]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/db/schema.rb#L20
