# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    description { "MyText" }
    user
    longitude { "7.696240" }
    latitude { "45.072300" }

    factory :post_with_picture do
      after :create do |b|
        b.update_column(:picture, "spec/fixtures/files/image.png")
      end
    end
  end
end
