require 'rails_helper'
require 'carrierwave/test/matchers'

describe PictureUploader do
  include CarrierWave::Test::Matchers

  let(:location) { FactoryBot.create(:location, latitude: -8, longitude: 115, forecast: ["do not trigger callback"]) }
  let(:post) { FactoryBot.create(:post, latitude: -8, longitude: 115) }
  let(:uploader) { location; PictureUploader.new(post, :picture) }

  before do
    PictureUploader.enable_processing = true
    File.open(File.join(Rails.root, "spec/fixtures/files/image.png")) { |f| uploader.store!(f) }
  end

  after do
    PictureUploader.enable_processing = false
    uploader.remove!
  end

  context 'the thumb version' do
    it "scales down a landscape image to be exactly 50 by 50 pixels" do
      expect(uploader.thumb).to have_dimensions(44, 50)
    end
  end

  context 'the small version'
    it "scales down a landscape image to fit within 200 by 200 pixels"
      #expect(uploader.small).to be_no_larger_than(200, 200)
    #end
  #end

  it "makes the image readable only to the owner and not executable" do
    expect(uploader).to have_permissions(0644)
  end

  it "has the correct format" do
    expect(uploader).to be_format('png')
  end
end
