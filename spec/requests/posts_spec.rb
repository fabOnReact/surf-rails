require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

RSpec.describe "Posts", type: :request do
  let(:valid_attributes) { FactoryBot.attributes_for(:post, longitude: 1 , latitude: 1)} #, user_id: @user.id
  let(:valid_base64_image) { Base64.encode64(File.read('spec/assets/test_image.jpg')) }

  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, :scope => :user)
  end

  after(:each) do
    Warden.test_reset!
  end

  describe "GET /posts"  #do		
#    it "does renter the index template" do
#      expect(response).to render_template(:index)
#    end
#
#    it "does return status 200" do
#      get posts_path
#      expect(response).to have_http_status(200)
#    end
#  end
#
  describe "GET /post/new" # do
#    it "does not render a different template" do
#      get new_post_path
#      expect(response).to_not render_template(:show)
#    end
#  end
#
  describe "user authenticates and create a new post" # do
#    before(:each) do
#      valid_attributes[:picture] = { file: valid_base64_image, name: 'test.png' }
#    end
#
#    it "creates a post, redirects to the show page and includes a notification" do
#      get new_post_path
#      expect(response).to render_template(:new)
#
#      post posts_path, params: {post: valid_attributes }
#
#      expect(response).to redirect_to(posts_path)
#      follow_redirect!
#
#      expect(response).to render_template(:index)
#      expect(response.body).to include("Post was successfully created.")
#    end
#
#    it 'creates a post and the post has latitude and longitude'
#    #   post posts_path, params: {post: valid_attributes }
#    #   expect(Post.last.longitude).not_to eql(0.0)
#    # end
#  end
end
