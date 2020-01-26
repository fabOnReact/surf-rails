# Table of Contents  
1. [Surf Database](#surf-database)  
2. [JSON Web Api](#json-web-api)
3. [React Native App](#react-native-app)
4. [Forecast Engine](#forecast-engine)  
   a. [Retrieving Weather Forecast via Api](#step-1-retrieving-information-via-api)  
   b. [Creating Cron Jobs](#step-2-creating-cron-jobs)  
   c. [Calculating Surf Forecast](#step-3-calculating-surf-forecast)
5. [Things To Improve](#things-to-improve)  

# Surf Database
The `surf-rails` backend includes around 10.000 surfspots from **Europe**, **Oceania**, **Africa**, **America** and **Asia**, it's the first public api endpoint, currently the [magicseaweed api][6] does not provide this information.

<p align="center">
  <img src="https://portfoliofabrizio.s3.eu-central-1.amazonaws.com/surfcheck/europe.png" width="250px" style="width:250px"/>
  <img src="https://portfoliofabrizio.s3.eu-central-1.amazonaws.com/surfcheck/australia.png" width="250px" style="width:250px"/>
  <img src="https://portfoliofabrizio.s3.eu-central-1.amazonaws.com/surfcheck/africa.png" width="250px" style="width:250px"/>
  <img src="https://portfoliofabrizio.s3.eu-central-1.amazonaws.com/surfcheck/NorthAmerica.png" width="250px" style="width:250px"/>
  <img src="https://portfoliofabrizio.s3.eu-central-1.amazonaws.com/surfcheck/SouthAmerica.png" width="250px" style="width:250px"/>
  <img src="https://portfoliofabrizio.s3.eu-central-1.amazonaws.com/surfcheck/asia.png" width="250px" style="width:250px"/>
</p>

# Json Web Api
Each SurfSpot is represented as a [`location`][1] model in Ruby on Rails and it is [reverse geocoded][5] with the [`longitude`][4] and [`latitude`][4]. Each location includes information relative to the surf spot which are essential to calculate the surf forecast, for example [`best_wind_direction`][2] and [`best_swell_direction`][2] to display the green and red indicators in the mobile app. The *green*/*red* indicator represent [*wind*][10] or [*waves*][9] coming from *optimal*/*non-optimal* directions (*offshore* or *onshore*). 

<p align="center">
  <img src="https://portfoliofabrizio.s3.eu-central-1.amazonaws.com/surfcheck/WindDirection.png" width="250px" style="width:250px"/>
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

The Mobile App retrieves the information through the [`/locations`][7] endpoint.
The [`/locations`][7] endpoint accepts three type of queries:
1) Locations filtered by `distance` from specific coordinates ([`#set_nearby_locations`][12]) 
2) Locations filtered within a [`bounding box`][11] ([`#set_locations_with_box`][13])
3) Locations that have videos of the surf conditions ([`#set_locations_with_cameras`][14])

An example curl request:

```curl
curl --location --request GET 'https://surfcheck.xyz/api/v1/posts.json?longitude=115.165524&latitude=-8.730649&page=1&per_page=4' \
--header 'X-User-Email: testing@torino1' \
--header 'X-User-Token: bGEfYLE72KtkGyQ21bcP' \
--header 'Accept: {{Accept}}' \
--header 'Content-Type: {{Content}}' \
--data-raw ''
```

More updated information and test cases are available in the `/locations` [api endpoint documentation][7].

# React Native App

The react native app retrieves from the `/locations` api endpoint the locations, forecast, videos information in the [`Locations`][15] `component` using the [`Api`][16] `class`. The information are retrieved at the application startup and cached. 
The same endpoint is used to display the different surfspots during map navigation with the [Map][17] `component` and the [Map][18] `class`.

<p align="center">
  <img src="https://portfoliofabrizio.s3.eu-central-1.amazonaws.com/surfcheck/map.png" width="250px" style="width:250px"/>
  <img src="https://portfoliofabrizio.s3.eu-central-1.amazonaws.com/surfcheck/video.png" width="250px" style="width:250px"/>
</p>

[11]: https://github.com/alexreisner/geocoder#advanced-database-queries
[12]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/app/controllers/locations_controller.rb#L36
[13]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/app/controllers/locations_controller.rb#L23
[14]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/app/controllers/locations_controller.rb#L28
[15]: https://github.com/fabriziobertoglio1987/surf-react-native/blob/master/app/components/index/Locations.js#L49
[16]: https://github.com/fabriziobertoglio1987/surf-react-native/blob/master/app/lib/api.js#L6
[17]: https://github.com/fabriziobertoglio1987/surf-react-native/blob/master/app/screens/MapScreen.js#L52-L65
[18]: https://github.com/fabriziobertoglio1987/surf-react-native/blob/master/app/lib/map.js#L3

The [`MapScreen`][36] renders the [`MapView`][35] Component and uses the [`Map`][18] class below to determine if the locations `#shouldUpdate()`.  
The `map` instance variable is used inside the react `MapScreen` component [`#handleRegionChange`][17] callback to re-render the page relevant surfspots. The method `shouldUpdate()` will detect if the user scrolled to a new region of the map.

```javascript
class Map {
  constructor (coords) {
    this._current = coords
    this._previous = coords
  }

  get zoomOut() { return this.delta > 5; }
  get zoomIn() { return 0.5 > this.delta > 0.1 }
  get noZoom() { return 0.5 < this.delta < 1.5; }

  get shift() {
    return this.noZoom && this.scroll
  }

  get scroll() {
    return this.scroll_horizontal || this.scroll_vertical
  }

  get shouldUpdate() { 
    return this.zoomIn || this.zoomOut || this.shift 
  }
}
```

Additionally the ReactNative app allows users to record and upload videos. The functionality is included in the [`Camera`][37] Component which uses the [`Recorder`][38] component to record the video and the [`Player`][39] component to upload it.

# Forecast Engine

The forecast information are retrieved from the stormglass api [endpoint][19] `/weather/point`. 
The application targets a specific country (Indonesia, [Bali][29]) with the plan and potential to expand to other areas in the world. Forecast are retrieved only for locations featured in the landing page with at least one uploaded surfing video, limiting background jobs memory usage and video playback server expenses. 

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


[19]: https://docs.stormglass.io/#point-request
[20]: https://www.youtube.com/watch?v=xFFs9UgOAlE&t=1993s?t=265
[21]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/app/models/location.rb#L106
[22]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/app/workers/weekly_forecast_worker.rb
[23]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/app/models/forecast.rb


#### STEP 2 Creating Cron Jobs
[Creates a cron job][24] to repeat the [`WeeklyForecastWorker`][22] 3 times a week.

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
 
 # generates def time, def swellHeight 
  KEYS.each do |method|
    define_method(method) { current.value(method) }
  end

  # generates def swellHeight_at(time), def windSpeed_at(time)
  KEYS.each do |method|
    define_method("#{method}_at(time)".to_sym) do
      select { |row| row["time"] == time }.first.value(method)
    end
  end
end
```

The [`Forecast`][30] Model uses the `Weather` class [`#daily`][31] method to calculate the daily average forecast.

```ruby
class Forecast < ApplicationRecord
  belongs_to :location
  KEYS = %w(swellHeight waveHeight windSpeed windDirection 
  waveDirection swellDirection swellPeriod)

  def weather
    Weather.new(read_attribute(:weather) || [])
  end
  
  # generates the following methods
  # def get_swell_height(days) def get_wave_height(days) 
  # def get_wind_speed(days) def get_wind_direction(days) 
  # def get_wave_direction(days) def get_swell_direction(days) 
  # def get_swell_period(days)
  KEYS.each do |field|
    define_method("get_#{field.duckTyped}(days)") do |days|
      weather.daily(field, days)
    end
  end

  # uses above get methods to calculate daily forecast
  def get_daily(days)
    result ||= KEYS.map do |field|
      # send(:get_wind_speed(days), days)
      daily_forecast = send("get_#{field.duckTyped}(days)".to_sym, days)
      [field, daily_forecast]
    end
    size = result.first.second.size - 1
    result += [["days", days.in_words[0..size]]]
    result.to_h
  end
end

```


[24]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/app/models/location.rb#L111-L117
[25]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/app/models/forecast.rb#L11-L13
[26]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/lib/weather.rb#L3
[27]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/lib/weather.rb#L15-L27
[30]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/app/models/forecast.rb#L15-L34
[31]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/lib/weather.rb#L115-L118


The [`DailyForecastWorkers`][32] schedules the calculation of daily forecast.  
Forecast are calculated based on the [`Location` timezone][33], as surfing is possible only at daytime. 

```ruby
class Location < ApplicationRecord
  # returns a list of local dates based on the location Timezome
  #  => [Sun, 26 Jan 2020 19:47:22 WITA +08:00, ...]
  def week_days
    @week_days ||= (DateTime.now..DateTime.now + 6).map do |day|
      day.in_time_zone(timezone["timeZoneId"])
    end
  end
  
  def get_daily
    # uses the local timezones to calculate the forecast
    daily = forecast.get_daily(week_days)
    # checks if wind/swell directions are optimal
    %w(wind swell).each do |attr|
      daily["optimal_#{attr}"] = daily["#{attr}Direction"].map do |value|
        send("optimal_#{attr}?(#{attr})", value.in_word)
      end
    end
    daily
  end
end
```

The Weather [`#daily`][34] method is responsible for calculating the `dailyAverage` swell and wind based of the location timezone.

```ruby
class Weather < Array
  def daily(key, week_days)
    return nil unless available?
    week_days.map { |day| dailyAverage(key, day) }.delete_if { |x| x.nil? }
  end
end
```


# Things to Improve
1. Full Test Coverage (`jest` unit test and `detox` e2e tests) of  the react native mobile app
2. Refactor the React application
3. Fixing rspec tests 
4. Speeding up rspec tests with vcr
6. Optimizing weather engine  
   a. retrieve weather forecast based on closest [buoy][28] and not gps  
   `location belongs_to :weather_station`  
   b. refactor the `weather` class and avoid code repetition between `location` and  `forecast` model  
   c. `Weather` class does not have a constructor  
   d. Refactor json response structure 
5. Continuos Integration
6. Fastlane

[28]: https://en.wikipedia.org/wiki/Buoy
[29]: https://en.wikipedia.org/wiki/Bali
[32]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/app/workers/daily_forecast_worker.rb
[33]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/db/schema.rb#L56
[34]: https://github.com/fabriziobertoglio1987/surf-rails/blob/master/lib/weather.rb#L114-117
[35]: https://github.com/react-native-community/react-native-maps/blob/master/docs/mapview.md
[36]: https://github.com/fabriziobertoglio1987/surf-react-native/blob/master/app/screens/MapScreen.js#L93
[37]: https://github.com/fabriziobertoglio1987/surf-react-native/blob/master/app/screens/CameraScreen.js
[38]: https://github.com/fabriziobertoglio1987/surf-react-native/blob/master/app/components/camera/Recorder.js
[39]: https://github.com/fabriziobertoglio1987/surf-react-native/blob/master/app/components/camera/Player.js
