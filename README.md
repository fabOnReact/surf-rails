# Surfcheck Backend and WebApplication
Backend and WebApplication for the Surfcheck app.
This is the backend of the [SurfCheck Mobile Android and Iphone app](https://github.com/fabriziobertoglio1987/surfnative) built with ReactNative.
The repository includes also a webapplication built with ruby on rails.

## Installation Instructions
ruby version `ruby 2.5.0`

rails `5.1.3`

Installation

```ruby
git clone git@github.com:fabriziobertoglio1987/surfcheck.git
bundle install
yarn install
```

run `rspec` for running test suite

The [repository of the ReactNative Mobile App](https://github.com/fabriziobertoglio1987/surfnative).

## Features
- API/Web Authentication was built with [Devise](https://github.com/plataformatec/devise) as explained in this [stackoverflow answer](https://stackoverflow.com/questions/55788412/rails-admin-not-authenticating-with-cancancan-or-devise/55940092#55940092), [simple token authentication](https://github.com/gonzalo-bulnes/simple_token_authentication). I enhanced the [devise registration and sessions controllers](https://github.com/fabriziobertoglio1987/surfcheck/tree/master/app/controllers/users) to handle API-Authentication
- Web/API pictures upload built with [carrierwave](https://github.com/carrierwaveuploader/carrierwave) and the [following solution](https://stackoverflow.com/questions/54202366/api-upload-multipartform-data)
- Responsive WebPage built with `Twitter-Bootstrap 4`
- [`Geocoder`][1] to `reverse geocode` database entries based on the GPS latitude and longitude coordinates
- `Geospatial Queries` by [user coordinates or bounding box][2]


[1]: https://github.com/alexreisner/geocoder
[2]: https://github.com/alexreisner/geocoder#advanced-database-queries
