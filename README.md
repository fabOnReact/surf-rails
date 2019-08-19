<p align="center">
  <img src="https://portfoliofabrizio.s3.eu-central-1.amazonaws.com/surfcheck.gif"/>
</p>

# Surfcheck Backend and WebApplication
- The [github repo](https://github.com/fabriziobertoglio1987/surfnative) of the ReactNative Mobile app using this api.
- The [webapplication](https://surfcheck.xyz)
- The api [endpoints, documentation and postman requests](https://documenter.getpostman.com/view/6379421/SVfH1CeA?version=latest). The api is public and free.

## Installation Instructions
ruby version `ruby 2.5.0`

rails `5.1.3`

Installation

```ruby
git clone git@github.com:fabriziobertoglio1987/surfcheck.git
bundle install
yarn install
```

run `rspec` for running test suite. Specs are currently not completed and some will fail. They will be fixed in the future.


## Features
- API/Web Authentication was built with [Devise](https://github.com/plataformatec/devise) as explained in this [stackoverflow answer](https://stackoverflow.com/questions/55788412/rails-admin-not-authenticating-with-cancancan-or-devise/55940092#55940092), [simple token authentication](https://github.com/gonzalo-bulnes/simple_token_authentication). I enhanced the [devise registration and sessions controllers](https://github.com/fabriziobertoglio1987/surfcheck/tree/master/app/controllers/users) to handle API-Authentication
- Web/API pictures upload built with [carrierwave](https://github.com/carrierwaveuploader/carrierwave) and the [following solution](https://stackoverflow.com/questions/54202366/api-upload-multipartform-data)
- Responsive WebPage built with `Twitter-Bootstrap 4`
- [`Geocoder`][1] to `reverse geocode` database entries based on the GPS latitude and longitude coordinates
- `Geospatial Queries` by [user coordinates or bounding box][2]
- Offering over 1 Million of surfspots information in the world with gps coordinates, pictures, wave forecast and surfspot information available in the webapplication, Iphone and Android native apps and json-api.
- Sidekiq and Cron-Sidekiq jobs to retrieve and calculate forecasts information
- Hosting on Digital Ocean
- Native Mobile Iphone and Android application


The OpenSource project is a mirror of the backend and includes 99% of the functionalities. 
Some features are kept private and they are not disclosed to the public.


[1]: https://github.com/alexreisner/geocoder
[2]: https://github.com/alexreisner/geocoder#advanced-database-queries
