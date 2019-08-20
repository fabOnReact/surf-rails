require 'rails_helper'

RSpec.describe "posts/edit", type: :view do
  let(:location) { FactoryBot.create(:location, latitude: -8, longitude: 115, forecast: ["do not trigger callback"]) }
  let(:post) { FactoryBot.create(:post_with_picture, latitude: -8, longitude: 115) }
  before(:each) do
    location
    @post = assign(:post, post)
  end

  it "renders the edit post form" do
    render

    assert_select "form[action=?][method=?]", post_path(@post), "post" do
    end
  end
end
