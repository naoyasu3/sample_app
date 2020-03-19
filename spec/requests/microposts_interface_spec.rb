require 'rails_helper'

RSpec.describe "MicroPostsSpec", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, :archer) }

  it "micropost interface" do
    log_in_as(user)
    #get user_path(user)
    # 無効な送信
    post microposts_path, params: { micropost: { content: "" } }
    assert_select 'div#error_explanation'
    # 有効な送信
    content = "This micropost really ties the room together"
    expect{
      post microposts_path, params: { micropost: { content: content } }
    }.to change(Micropost, :count).by(1)
    # 投稿を削除する
    first_micropost = user.microposts.paginate(page: 1).first
    expect{
      delete micropost_path(first_micropost)
    }.to change(Micropost, :count).by(-1)
    # 違うユーザーのプロフィールにアクセスする
    get user_path(other_user)
    assert_select 'a', { text: 'delete', count: 0 }
  end
end