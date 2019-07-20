require 'rails_helper'
require 'api/storm_glass'

RSpec.describe Location, type: :model do
  let(:location) { FactoryBot.create(:location) }

  describe "#set_forecast" do 
    it "triggers and records a job" do
    end
  end
end
