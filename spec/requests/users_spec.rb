require 'rails_helper'

RSpec.describe "Users", type: :request do
	describe "GET /users" do
		it "works! (now write some real specs)" do
			get new_user_session_path
			expect(response).to have_http_status(200)
		end
	end

	describe 'authentication with facebook OmniAuth' do
    OmniAuth.config.test_mode = true		 
 
		it 'authenticates the user with facebook omniauth' do
	  		get '/users/auth/facebook' 
	  		expect(response.status).to be(302)
	  	end

	    it 'authenticates the user with facebook omniauth' do
	  		get '/users/auth/facebook' 
	  		expect(response).to redirect_to('http://127.0.0.1:3000/users/auth/facebook/callback')
	  	end
	end

  context 'registered users' do
    before(:each) do
      get new_user_session_path
      expect(response).to render_template(:new)

      @user = FactoryBot.create(:user)
    end

    describe 'testing sign-in process' do
      it 'correctly sign in with correct credentials' do
        post user_session_path, :params => { :user => { :email => @user.email, :password => @user.password }}
        expect(response).to redirect_to(root_path)
        follow_redirect!

        expect(response).to render_template(:landing)
        expect(response.body).to include("landing page")
      end

      it 're-render the sign-in page and an error message' do 
        post user_session_path, :params => { :user => { :email => @user.email, :password => 'wrong-password' }}

        expect(response).to render_template(:new)
        expect(response.body.downcase).to include("invalid email or password")
      end      
    end

    describe 'testing sign-out process' do
      it 'sucessfully sign out' do
        delete destroy_user_session_path
        expect(response).to redirect_to(root_path)
        follow_redirect!

        expect(response).to render_template(:landing)
        expect(response.body.downcase).to include("signed out successfully")
      end      
    end
  end

  context 'visitor' do 
    it 'displays the landing page without authentication' do
      get root_path
      expect(response).to render_template(:landing)
      expect(response.body.downcase).not_to include('error')
      expect(response.body.downcase).to include("landing page")
    end

    it 'displays the posts/index page without authentication' do 
      get posts_path
      expect(response).to render_template(:index)
      expect(response.body.downcase).not_to include('error')
    end

    it 'requires authentication to make a post' do 
      get new_post_path
      expect(response).to redirect_to(new_user_session_path)
      follow_redirect!

      expect(response).to render_template(:new)
      expect(response.body.downcase).to include('you need to sign in or sign up before continuing')
    end
  end
end
