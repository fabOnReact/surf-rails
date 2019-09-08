Dir[File.join(Rails.root, 'lib', 'core_ext', '*.rb')].each do |file|
  require file
end

Dir[File.join(Rails.root, 'lib', 'core_ext', 'action_dispatch', 'http', '*.rb')].each { |l| require l }

require 'core_ext/string'
require 'core_ext/hash'
require 'mechanize'
require 'scraper'
require 'continent'
require 'scraper/spot'
require 'scraper/country'
require 'api/storm'
require 'api/google'
require 'forecast/weather'
