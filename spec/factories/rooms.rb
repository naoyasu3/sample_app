FactoryBot.define do
  factory :room do
    sequence(:name) { |n| "Chat_room_#{n}" }
  end
end
