require 'rails_helper'

RSpec.describe "UsersIndexSpec", type: :system do
  let!(:admin) { FactoryBot.create(:user, :michael) }
  let!(:non_admin) { FactoryBot.create(:user, :archer) }

  scenario "index as admin including pagination and delete links" do
    FactoryBot.create_list(:user, 30)
    log_in_as(admin)
    expect(page).to have_content admin.name
    visit users_path
    expect(page).to have_content "All users"
    expect(page).to have_css ".pagination"
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      expect(page).to have_selector 'li', text: user.name
      if not user == admin
        expect(page).to have_selector 'a[data-method=delete]', text: 'delete'
      end
    end
    expect{
      find(".users-delete-#{non_admin.id}").click
    }.to change(User, :count).by(-1)
  end

  scenario "index as non-admin" do
    log_in_as(non_admin)
    visit users_path
    expect(page).to_not have_content "delete"
  end
end