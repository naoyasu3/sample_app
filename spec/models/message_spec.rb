require 'rails_helper'

RSpec.describe Message, type: :model do
  it { is_expected.to validate_presence_of :content }
  it { is_expected.to validate_presence_of :user_id }
  it { is_expected.to validate_presence_of :room_id }
end
