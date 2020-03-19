require 'rails_helper'

RSpec.describe "UsersProfileSpec", type: :system do
  let(:user) { FactoryBot.build(:user) }

  scenario "invalid signup information" do
    visit root_path
    click_link "Sign up now!"
    fill_in "Name",	with: "" 
    fill_in "Email",	with: "user@invalid"
    fill_in "Password",	with: "foo"
    fill_in "Confirmation",	with: "bar" 
    click_button "Create my account"
    expect(page).to have_selector('.alert-danger', text: 'The form contains 3 errors.')
  end

  scenario "valid signup information with account activation"  do
    visit root_path
    click_link "Sign up now!"
    expect{
      fill_in "Name",	with: user.name
      fill_in "Email",	with: user.email
      fill_in "Password",	with: user.password
      fill_in "Confirmation",	with: user.password
      click_button "Create my account"
    }.to change(User, :count).by(1)
    expect(page).to have_selector('.alert-info', text: 'Please check your email to activate your account.')
    log_in_as(user)
    not_log_in_as?

    User.last.update(activated: true)
    log_in_as(user)
    log_in_as?
  end
end