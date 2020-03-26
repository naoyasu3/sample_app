require 'rails_helper'

RSpec.describe "RoomSpec", type: :system do
  let(:user) { FactoryBot.create(:user) }

  describe "Chat Room Page" do
    context "ログインしている" do
      before do
        log_in_as user
        visit rooms_path
      end

      it "新規チャットルームが作成できる" do
        fill_in "room_name",	with: "new_room" 
        click_button "作成"
        expect(page).to have_link "new_room"
        expect(page).to have_content "新しいチャットルームを作成しました"
      end
    end
    context "ログインしていない" do
      it "ログインページにリダイレクトされる" do
        visit rooms_path
        expect(page).to have_content "Log in"
        expect(page).to have_content "Please log in."
      end
    end
  end
end