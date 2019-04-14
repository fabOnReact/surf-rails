# frozen_string_literal: true

require 'base64'
require 'upload/cache'

describe Upload::Cache do
  let(:base64) { Base64.encode64(File.read('spec/assets/test_image.jpg')) }

  describe 'generate tempfile' do
    it 'retrive the base64 image' do
      expect(base64).to_not be("")
    end

    it 'decodes the image' do
      picture = { file: base64, name: 'file.jpg' }
      cache_file = Upload::Cache.new(picture)
      cache_file.rewind
      expect(cache_file.path).to_not be ""
    end
  end
end
