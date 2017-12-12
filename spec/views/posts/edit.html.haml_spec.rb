require 'rails_helper'

RSpec.describe "posts/edit", type: :view do
  before(:each) do
    @post = assign(:post, FactoryBot.create(:post))
  end

  it "renders the edit post form" do
    allow(controller).to receive(:action_name).and_return('new')
    render
    
    assert_select "form[action=?][method=?]", post_path(@post), "post" do
    end    
  end
end
