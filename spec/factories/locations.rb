FactoryBot.define do
  factory :location do
    direction { "MyString" }
    experience { "MyString" }
    frequency { "MyString" }
    wave_quality { "MyString" }
    name { "MyString" }
    latitude { "MyString" }
    longitude { "MyString" }
    country { "MyString" }
    forecast { [] }
  end
end
