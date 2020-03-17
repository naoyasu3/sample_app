FactoryBot.define do
  factory :micropost do
    sequence(:content) { |n| "micropost#{n}" }
  end
end