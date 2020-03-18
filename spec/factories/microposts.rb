FactoryBot.define do
  factory :micropost do
    sequence(:content) { |n| "micropost#{n}" }

    trait :most_recent do 
      content "Writing a short test"
      created_at Time.zone.now
    end
  end
end