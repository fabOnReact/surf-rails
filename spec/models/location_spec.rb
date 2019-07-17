require 'rails_helper'
require 'api/storm_glass'

RSpec.describe Location, type: :model do
  let(:location) { FactoryBot.create(:location) }
end
