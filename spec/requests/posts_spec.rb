require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

RSpec.describe "Posts", type: :request do
	before(:each) do
		@user = FactoryBot.create(:user)
		login_as(@user, :scope => :user)
	end

	let(:valid_attributes) { FactoryBot.attributes_for(:post, user_id: @user.id)} 

	after(:each) do
		Warden.test_reset!
	end

	describe "GET /posts" do		
		it "does renter the index template" do
			get posts_path
			expect(response).to render_template(:index)
		end

		it "does return status 200" do
			get posts_path
			expect(response).to have_http_status(200)
		end
	end

	describe "GET /post/new" do
		it "does not render a different template" do
			get new_post_path
			expect(response).to_not render_template(:show)
		end
	end

	describe "user authenticates and create a new post" do
		it "creates a post, redirects to the show page and includes a notification" do
	  		get new_post_path
	  		expect(response).to render_template(:new)

	  		post posts_path, params: {post: valid_attributes }

	  		expect(response).to redirect_to(assigns(:post))
	  		follow_redirect!

	  		expect(response).to render_template(:show)
	  		expect(response.body).to include("Post was successfully created.")
		end
	end
end
