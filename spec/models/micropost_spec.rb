require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user){ FactoryBot.create(:user) }
  let(:micropost){ FactoryBot.create(:micropost, user: user) }
  let(:most_recent){ FactoryBot.create(:micropost, :most_recent, user: user) }

  it "should be valid" do
    expect(micropost).to be_valid
  end

  it { is_expected.to validate_presence_of :user_id }
  it { is_expected.to validate_presence_of :content }
  it { is_expected.to validate_length_of(:content).is_at_most(140) }


  it "order should be most recent first" do
    expect(most_recent).to eq Micropost.first
  end
end
