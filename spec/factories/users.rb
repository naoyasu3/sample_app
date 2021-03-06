FactoryBot.define do
  factory :user do
    name "Example User" 
    sequence(:email) { |n| "user#{n}@example.com" }
    password "foobar" 
    password_confirmation "foobar"
    activated true
    activated_at Time.zone.now

    trait :michael do
      name "Michael Example"
      sequence(:email) { |n| "michael#{n}@example.com" }
      password "foobar" 
      password_confirmation "foobar"
      admin true
      activated true
      activated_at Time.zone.now
    end

    trait :archer do
      name "Sterling Archer"
      sequence(:email) { |n| "duchess#{n}@example.gov" }
      password "foobar" 
      password_confirmation "foobar"
      activated true
      activated_at Time.zone.now 
    end

    trait :lana do
      name "Lana Kane"
      sequence(:email) { |n| "hands#{n}@example.gov"}
      password "foobar" 
      password_confirmation "foobar"
      activated true
      activated_at Time.zone.now
    end
  end
end
