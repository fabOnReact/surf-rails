require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe 'when authenticating with the facebook api' # do
#    OmniAuth.config.test_mode = true		 
#
#    it 'will receive the correct 302 status in the response' do
#      get '/users/auth/facebook' 
#      expect(response.status).to be(302)
#    end
#
#    it 'will be redirected to the url set in the facebook developer console' do
#      get '/users/auth/facebook' 
#      expect(response).to redirect_to('http://lvh.me:3000/users/auth/facebook/callback')
#    end
#  end
#
  describe 'that already registered' # do
#    before(:each) do
#      get new_user_session_path
#      expect(response).to render_template(:new)
#
#      @user = FactoryBot.create(:user)
#    end
#
#    it 'can sign in with the correct credentials' do
#      post user_session_path, :params => { :user => { :email => @user.email, :password => @user.password }}
#      expect(response).to redirect_to(posts_path)
#      follow_redirect!
#
#      expect(response).to render_template("posts/index")
#    end
#
#    it 'receive an error message if using the wrong credentials' do 
#      post user_session_path, :params => { :user => { :email => @user.email, :password => 'wrong-password' }}
#
#      expect(response).to render_template(:new)
#      expect(response.body.downcase).to include("invalid email or password")
#    end      
#
#    it 'sucessfully sign out' do
#      delete destroy_user_session_path
#      expect(response).to redirect_to(root_path)
#      follow_redirect!
#
#      expect(response).to render_template(:landing)
#      expect(response.body.downcase).to include("signed out successfully")
#    end      
#  end
#
#  context 'not signed in' do 
#    it 'displays the landing page' do
#      get root_path
#      expect(response).to render_template(:landing)
#      expect(response.body.downcase).not_to include('error')
#      expect(response.body.downcase).to include("is an app that allows you to see the surf at different time")
#    end
#
#    it 'displays the posts/index page' do 
#      get posts_path
#      expect(response).to redirect_to(:new_user_session)
#      expect(response.body.downcase).not_to include('error')
#    end
#
#    it 'requires authentication to make a post' do 
#      get new_post_path
#      expect(response).to redirect_to(new_user_session_path)
#      follow_redirect!
#
#      expect(response).to render_template(:new)
#      expect(response.body.downcase).to include('you need to sign in or sign up before continuing')
#    end
#  end
end
