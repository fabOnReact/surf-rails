require 'rails_helper'

RSpec.describe "Users", type: :request do
	describe "GET /users" do
		it "works! (now write some real specs)" do
			get new_user_session_path
			expect(response).to have_http_status(200)
		end
	end

	describe 'GET /users/auth/facebook' do
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
end
