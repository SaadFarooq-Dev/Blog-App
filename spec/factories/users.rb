FactoryBot.define do
  factory :user do
    name { Faker::Name.name_with_middle }
    username { Faker::Internet.username(specifier: 5..30) }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 6, max_length: 70) }
    after :create, &:confirm
    trait :moderator do
      status { 'moderator' }
    end

    trait :admin do
      status { 'admin' }
    end
  end
end
