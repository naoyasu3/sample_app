require 'rails_helper'

RSpec.describe "UsersProfileSpec", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:micropost) { FactoryBot.create(:micropost, user: user) }

  scenario "profile display" do
    visit user_path(user)
    expect(page).to have_content user.name
    expect(page).to have_content micropost.content
  end
end