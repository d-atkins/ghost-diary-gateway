FactoryBot.define do
  factory :user do
    name { "#{Faker::Superhero.descriptor.delete(' ')}-#{Faker::Name.first_name}".downcase }
    role { 1 }
    uid { Faker::Number.number(digits: 10).to_s }
    association :group
  end
end
