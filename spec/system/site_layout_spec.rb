require 'rails_helper'

RSpec.describe "SiteLayoutSpec", type: :system do
  scenario "layout links" do
    visit root_path
    expect(page).to have_link "sample app"
    expect(page).to have_link "Help"
    expect(page).to have_link "About"
    expect(page).to have_link "Contact"
    expect(page).to have_link "Sign up now!"
  end
end