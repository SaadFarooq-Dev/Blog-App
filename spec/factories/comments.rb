FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.sentence(word_count: 5) }
    association :user
    association :post
  end
end
