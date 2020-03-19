require 'rails_helper'

RSpec.describe "UsersLoginSpec", type: :system do
let(:user) { FactoryBot.create(:user) }

  scenario "login with invalid information" do
    visit login_path
    fill_in "Email",	with: ""
    fill_in "Password",	with: ""
    click_button "Log in"
    expect(page).to have_selector('.alert-danger', text: 'Invalid email/password combination')
    visit root_path
    expect(page).to_not have_selector('.alert-danger', text: 'Invalid email/password combination')
  end

  scenario "login with valid information followed by logout" do
    log_in_as(user)
    within '.navbar-nav' do
      expect(page).to_not have_content 'Log in'
      expect(page).to have_content 'Account'
    end

    click_link 'Log out'
    within '.navbar-nav' do
      expect(page).to have_content 'Log in'
      expect(page).to_not have_content 'Account'
    end

  end
end