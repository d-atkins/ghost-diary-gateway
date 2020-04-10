FactoryBot.define do
  factory :day do
    association :group
    week { rand(1..6) }
    day_of_week { rand(0..6) }
  end
end
