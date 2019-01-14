class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file
  version :thumb do
    process resize_to_fit: [50, 50]
  end

  version :card do
    process resize_to_fit: [318, 180]
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
