FactoryBot.define do
  factory :post do
    body { [Faker::Quote.famous_last_words,
            Faker::Hacker.say_something_smart,
            Faker::GreekPhilosophers.quote]
            .sample.first(222) }
    tone { ['anger',
            'fear',
            'joy',
            'sadness',
            'analytical',
            'confident',
            'tentative'].sample }
    association :day
    association :user
  end
end
