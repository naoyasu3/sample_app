require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:micropost) { FactoryBot.create(:micropost, user: user) }
  let(:comment) { FactoryBot.create(:comment, user: user, micropost: micropost) }

  it { is_expected.to validate_presence_of :content }
  it { is_expected.to validate_length_of(:content).is_at_most(144) }
  it { is_expected.to validate_presence_of :user_id }
  it { is_expected.to validate_presence_of :micropost_id }

  it 'コメントできた場合' do
    expect(comment).to  be_valid
  end
end
