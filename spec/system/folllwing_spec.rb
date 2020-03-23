require 'rails_helper'

RSpec.describe "FollwingSpec", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:michael) { FactoryBot.create(:user, :michael) }
  let!(:archer) { FactoryBot.create(:user, :archer) }

  describe "follow RSpec test" do
    before do
      log_in_as(user)
    end

    it 'フォローしてから、フォロー解除した場合' do
      visit user_path(michael)
      expect(page).to have_selector('#followers', text: '0')
      expect{
        click_button 'Follow'
      }.to change(Relationship, :count).by(1)
      expect(page).to have_selector('#followers', text: '1')
      visit followers_user_path(michael)
      expect(page).to have_content user.name

      visit user_path(michael)
      expect(page).to have_selector('#followers', text: '1')
      expect{
        click_button 'Unfollow'
      }.to change(Relationship, :count).by(-1)
      expect(page).to have_selector('#followers', text: '0')
      visit followers_user_path(michael)
      expect(page).not_to have_content user.name
    end
  end
end