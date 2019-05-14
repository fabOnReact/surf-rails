class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :fog
  version :thumb do
    process resize_to_fit: [50, 50]
  end

  version :card do
    process resize_to_fit: [318, 180]
  end

  version :mobile do
    process resize_to_fit: [627, 355]
  end

  def store_dir
    date = Date.today
    "uploads/#{model.class.to_s.underscore}/#{date.year}/#{date.month}/#{model.user.id}"
  end


  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def field
    @field
  end

  def field=(field)
    @field = field
  end
end
