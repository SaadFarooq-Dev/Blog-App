FactoryBot.define do
  factory :suggestion do
    association :user
    association :post
  end
end
