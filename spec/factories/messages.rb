FactoryBot.define do
  factory :message do
    sequence(:content) { |n| "message#{n}" } 
    association :user
    association :room
  end
end
