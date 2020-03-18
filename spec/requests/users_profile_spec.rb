require 'rails_helper'

RSpec.describe "UsersProfileSpec", type: :request do
  #include ApplicationHelper
  let(:user) { FactoryBot.create(:user) }

  it "profile display" do
    get user_path(user)
    assert_template 'users/show'
    assert_select 'h1', text: user.name
    assert_select 'h1>img.gravatar'
    assert_match user.microposts.count.to_s, response.body
    user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end
end