require 'rails_helper'
require 'api/google'

describe Google::Auth do 
end

describe Google::Maps do
  let(:google) { Google::Maps.new("-8.745124,115.150323") }
  describe "#getTimezone" do
    it "retrieves the location Timezone" do
      timezone = google.getTimezone["timeZoneName"]
      expect(timezone).to eql "Central Indonesia Time"
    end
  end
end
