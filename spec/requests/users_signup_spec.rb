require 'rails_helper'
RSpec.describe "Users signup", type: :request do
  example "valid signup information with account activation" do
    get signup_path
    expect{
      post users_path, params: { user: { name:  "Example User",
                                 email: "user@example.com",
                                 password:              "password",
                                 password_confirmation: "password" } }
    }.to change(User, :count).by(1)

    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    expect(user.activated?).to be false
    # 有効化していない状態でログインしてみる
    log_in_as(user)
    expect(is_logged_in?).to be false
    # 有効化トークンが不正な場合
    get edit_account_activation_path("invalid token", email: user.email)
    expect(is_logged_in?).to be false
    # トークンは正しいがメールアドレスが無効な場合
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    expect(is_logged_in?).to be false
    # 有効化トークンが正しい場合
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end