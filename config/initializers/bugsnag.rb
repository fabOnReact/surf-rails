unless Rails.env.development? || Rails.env.test?
  Bugsnag.configure do |config|
    config.api_key = ENV['BUGSNAG_API_KEY'] 
  end
end
