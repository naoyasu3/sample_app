require 'rails_helper'

RSpec.describe "MicropostsInterfaceSpec", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:michael) }
  let!(:micropost) { FactoryBot.create(:micropost, user: user) }

  describe "micropost interface" do
    before do
      log_in_as(user)
      click_link 'Home'
    end

    context "正常系" do
      it "有効な送信" do
        fill_in "micropost_content",	with: "test"
        click_button "Post"
        expect(page).to_not have_selector('.alert-danger', text: 'The form contains 1 error.')
      end

      it "投稿を削除した場合" do
        expect{
          find("micropost-#{micropost.id}").click
        }.to change(Micropost, :count).by(-1) 
      end

      it "違うユーザのプロフィールにアクセスした場合" do
        visit user_path(other_user)
        expect(page).to_not have_content "delete"  
      end
    end

    context "異常系" do
      it "無効な送信" do
        fill_in "micropost_content",	with: ""
        click_button "Post"
        expect(page).to_not have_selector('.alert-danger', text: 'The form contains 1 error.')
      end
    end
  end
end