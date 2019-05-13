CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['S3_KEY'],
      :aws_secret_access_key  => ENV['S3_SECRET'],
      :region                 => 'eu-central-1',
      :host                   => 's3.eu-central-1.amazonaws.com',
      :endpoint               => 'https://s3.eu-central-1.amazonaws.com/'   
  }
  config.fog_directory  = 'surfcheck'
  config.cache_dir     = "#{Rails.root}/tmp/uploads"
end
