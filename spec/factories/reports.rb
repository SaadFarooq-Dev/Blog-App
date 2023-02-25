FactoryBot.define do
  factory :report do
    reason { Faker::Lorem.sentence(word_count: 5) }
    association :user

    trait :for_post do
      association(:reportable, factory: :post)
    end

    trait :for_comment do
      association(:reportable, factory: :comment)
    end
  end
end
