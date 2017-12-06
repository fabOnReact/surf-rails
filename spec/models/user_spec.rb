require 'rails_helper'

RSpec.describe User, type: :model do

  it { should have_many :posts }

  before(:each) { @user = FactoryBot.create(:user)}

  subject { @user }

  it { should respond_to(:email)}

  it '#email returns a string' do
  	expect(@user.email.class).to be(String)
  end 

  describe '.from_omniauth' do
  	it 'should respond with the user' do
	  	token = OmniAuth::AuthHash.new({"info" => {"email" => @user.email }}) 	
	  	expect(User.from_omniauth(token)).to be_instance_of(User)
  	end
  end

  describe '.new_with_session' do
  	it 'should set the email' do
  		session = {"devise.facebook_data" => {"email" => "test@email.com", "extra" => {"raw_info" => {"email" => "second@email.com"}}}}
  		params = {"password" => "12345678", "password_confirmation" => "12345678"}
  		expect(User.new_with_session(params, session).email).to eql("second@email.com")
  	end
  end
end