require 'rails_helper'

RSpec.describe User, type: :model do
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
end