require 'rails_helper'
require 'api/storm'

RSpec.describe Location, type: :model do
  subject { Location.new }
  let(:location) { FactoryBot.build(:location, latitude: 1, longitude: 1) }
end
