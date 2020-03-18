require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:michael) { FactoryBot.create(:user, :michael) }
  let(:archer) { FactoryBot.create(:user, :archer) }

  it "should be valid" do
    relationship = Relationship.new(follower_id: michael.id,
                                     followed_id: archer.id)
    expect(relationship).to be_valid
  end

  it { is_expected.to validate_presence_of :follower_id }
  it { is_expected.to validate_presence_of :followed_id }
end
