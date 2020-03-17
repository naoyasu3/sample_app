require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:michael) { FactoryBot.create(:user, :michael) }
  let(:archer) { FactoryBot.create(:user, :archer) }
  let(:lana) { FactoryBot.create(:user, :lana) }
  let!(:micropost) { FactoryBot.create(:micropost, user: user) }

  it "should be valid" do
   expect(user).to be_valid
  end

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_length_of(:name).is_at_most(50) }

  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_length_of(:email).is_at_most(255) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  it { is_expected.to validate_presence_of :password }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }
  
  it "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user.email = valid_address
      expect(user).to be_valid
    end
  end

  it "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user).to_not be_valid
    end
  end

  it "authenticated? should return false for a user with nil digest" do
    expect(user.authenticated?(:remember, '')).to eq false
  end

  it "associated microposts should be destroyed" do
    expect{
      user.destroy
    }.to change(Micropost, :count).by(-1)
  end

  it "should follow and unfollow a user" do
    expect(michael.following?(archer)).to eq false
    michael.follow(archer)
    assert michael.following?(archer)
    assert archer.followers.include?(michael)
    michael.unfollow(archer)
    expect(michael.following?(archer)).to eq false
  end

  it "feed should have the right posts" do
    # フォローしているユーザーの投稿を確認
    lana.microposts.each do |post_following|
      expect(michael.feed.include?(post_following)).to eq true
    end
    # 自分自身の投稿を確認
    michael.microposts.each do |post_self|
      expect(michael.feed.include?(post_self)).to eq true
    end
    # フォローしていないユーザーの投稿を確認
    archer.microposts.each do |post_unfollowed|
      expect(michael.feed.include?(post_unfollowed)).to eq true
    end
  end
end
