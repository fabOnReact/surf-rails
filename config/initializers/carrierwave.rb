require 'fog/aws'

CarrierWave::Uploader::Base.descendants.each do |klass|
	next if klass.anonymous?
	klass.class_eval do
		def cache_dir
			"#{Rails.root}/spec/support/uploads/tmp"
		end

		def store_dir
			"#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
	    end
	end
end

CarrierWave.configure do |config|
  if Rails.env.test?
    config.storage :file
    config.asset_host = 'http://localhost:3000'
  else
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['S3_KEY'],
      :aws_secret_access_key  => ENV['S3_SECRET'],
      :region                 => 'eu-central-1',
      :host                   => 's3.eu-central-1.amazonaws.com',
      :endpoint               => 'https://s3.eu-central-1.amazonaws.com'   
    }
    # config.storage = :fog
    # config.fog_use_ssl_for_aws = true
    config.fog_public     = true
    config.fog_attributes = { 'Cache-Control': 'max-age=315576000' }
    config.fog_directory  = 'surfcheck'
    config.cache_dir     = "#{Rails.root}/tmp/uploads"
  end
end
