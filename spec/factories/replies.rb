FactoryBot.define do
  factory :reply do
    body { Faker::Commerce.product_name }

    association :user
    association :suggestion
  end
end
