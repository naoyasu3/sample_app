FactoryBot.define do
  factory :user do
    name "Example User" 
    sequence(:email) { |n| "user#{n}@example.com" }
    password "foobar" 
    password_confirmation "foobar"

    trait :michael do
      name "michael"
    end

    trait :archer do
      name "archer"
    end
    
    trait :lana do
      name "lana"
    end
  end
end
