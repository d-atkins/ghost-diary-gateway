FactoryBot.define do
  factory :group do
    name { "#{Faker::Science.element} School BE Mod #{Faker::Number.within(range: 0..500)}" }
  end
end
