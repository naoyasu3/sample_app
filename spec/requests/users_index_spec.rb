require 'rails_helper'

RSpec.describe "UsersIndexSpec", type: :request do
  let!(:admin) { FactoryBot.create(:user, :michael) }
  let!(:non_admin) { FactoryBot.create(:user, :archer) }

  it "index as admin including pagination and delete links" do
    log_in_as(admin)
    expect(response).to redirect_to user_path(admin)
    get users_path
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    expect{
      delete user_path(non_admin)
    }.to change(User, :count).by(-1)
  end

  it "index as non-admin" do
    log_in_as(non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end
