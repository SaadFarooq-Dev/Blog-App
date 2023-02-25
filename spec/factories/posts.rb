FactoryBot.define do
  factory :post do
    association :user
    title { Faker::Lorem.sentence(word_count: 10) }
    content { Faker::Lorem.sentence(word_count: 6) }

    trait :with_suggestion do
      after(:create) do |post|
        create(:suggestion, title: post.title, content: post.content, post_id: post.id, user_id: post.user_id)
      end
    end
  end
end
