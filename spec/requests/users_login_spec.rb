require 'rails_helper'

RSpec.describe "UsersLoginSpec", type: :request do
  let!(:user) { FactoryBot.create(:user) }

  it "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    expect(flash.empty?).to eq false
    get root_path
    expect(flash.empty?).to eq true
  end

  it "login with valid information followed by logout" do
    get login_path
    log_in_as user
    expect(is_logged_in?).to eq true
    assert_redirected_to user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(user)
    delete logout_path
    expect(is_logged_in?).to eq false
    expect(response).to redirect_to root_url
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(user), count: 0
  end

  it "login with remembering" do
    log_in_as(user, 1)
    expect(cookies['remember_token']).to_not be_empty
  end

  it "login without remembering" do
    # クッキーを保存してログイン
    log_in_as(user, 1)
    delete logout_path
    # クッキーを削除してログイン
    log_in_as(user, 0)
    expect(cookies['remember_token']).to be_empty
  end
end