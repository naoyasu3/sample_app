FactoryBot.define do
  factory :message do
    content "MyText"
    association user
    association room
  end
end
