require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  let(:location) { FactoryBot.create(:location, latitude: -8, longitude: 115, forecast: ["do not trigger callback"]) }
  let(:post) { FactoryBot.create(:post_with_picture, latitude: -8, longitude: 115) }
  before(:each) do
    location  
    @post = assign(:post, post)
    assign(:posts, [ @post, @post ])
  end

  it "renders a list of posts" do
    render
  end
end
