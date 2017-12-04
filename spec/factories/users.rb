FactoryBot.define do
  factory :user do
  	email Faker::Internet.email
  	password Faker::Internet.password
  	# confirmed_at Faker::Date.between(10.days.ago, Date.today)    
  end
end
