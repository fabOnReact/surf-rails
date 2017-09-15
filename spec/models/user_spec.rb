require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) { @user = FactoryGirl.build(:user)}

  subject { @user }

  it { should respond_to(:email)}

  it '#email returns a string' do
  	expect(@user.email.class).to be(String)
  end 
end
