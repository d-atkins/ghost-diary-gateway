FactoryBot.define do
  factory :reaction do
    category { rand(0..4) }
    association :user
    association :post
  end
end
