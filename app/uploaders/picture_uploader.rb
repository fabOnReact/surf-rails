class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :fog
  version :thumb do
    process resize_to_fit: [50, 50]
  end

  version :card do
    process resize_to_fit: [318, 180]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
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
