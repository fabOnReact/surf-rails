# frozen_string_literal: true

require 'base64'
require 'upload/image'
require 'upload/cache'

describe Upload::Image do
  let(:base64) { Base64.encode64(File.read('spec/assets/test_image.jpg')) }
  let(:cached_file) { Upload::Cache.new({ file: base64, name: 'file.jpg' }) }
  describe 'generate an uploaded file' do
    it 'store the temporary file as an UploadedFile' do
      image = Upload::Image.new(cached_file)
      expect(image.tempfile).to be_present
      expect(image.tempfile.path).to_not be ""
    end
  end
end
