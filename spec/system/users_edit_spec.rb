require 'rails_helper'

RSpec.describe "UsersEditSpec", type: :system do
  let(:user) { FactoryBot.create(:user) }

  scenario "unsuccessful edit" do
    log_in_as(user)
    click_link "Settings"
    fill_in "Name",	with: ""
    fill_in "Email",	with: "foo@invalid"
    fill_in "Password",	with: "foo"
    fill_in "Confirmation",	with: "bar" 
    click_button "Save changes"
    expect(page).to have_selector('.alert-danger', text: 'The form contains 3 errors.')
  end

  scenario "successful edit with friendly forwarding" do
    log_in_as(user)
    click_link "Settings"
    fill_in "Name",	with: "Foo Bar"
    fill_in "Email",	with: "foo@bar.com"
    click_button "Save changes"
    expect(page).to have_selector('.alert-success', text: 'Profile updated')
  end
end