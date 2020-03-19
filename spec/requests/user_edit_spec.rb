require 'rails_helper'

RSpec.describe "UsersEditSpec", type: :request do
  let(:user) { FactoryBot.create(:user) }

  it "unsuccessful edit" do
    log_in_as user
    get edit_user_path(user)
    assert_template 'users/edit'
    patch user_path(user), params: { user: { name:  "",
                                              email: "fooinvalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
  end

  it "successful edit with friendly forwarding" do
    edit_user = user
    get edit_user_path(edit_user)
    log_in_as(edit_user)
    assert_redirected_to edit_user_url(edit_user)
    name  = "Foo Bar"
    email = "foobar.com"
    patch user_path(edit_user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    expect(flash).to_not be_empty
    expect(response).to have_http_status :success
  end
end