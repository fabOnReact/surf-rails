AssetSync.configure do |config|
  config.fog_provider = 'AWS'
  config.aws_access_key_id = ENV.fetch('AWS_ACCESS_KEY_ID_IAM')
  config.aws_secret_access_key = ENV.fetch('AWS_SECRET_ACCESS_KEY_IAM')
  config.fog_directory = 'portfoliofabrizio'
  config.fog_region = 'eu-central-1'
end
