require 'rails_helper'

RSpec.describe "MessageSpec", type: :system, js: true do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, :michael) }
  let!(:room) { FactoryBot.create(:room) }
  let(:message) { FactoryBot.create(:message, user: user, room: room) }

  describe "チャットルーム" do
    context 'ログインしている' do
      before do
        log_in_as user
        visit room_path(room)
      end
      it 'メッセージ投稿できている' do
        fill_in "chat_input",	with: "test!"
        # find('#chat_input').native.send_key(:enter)
        keypress = "var e = $.Event('keydown', { keyCode: 13 }); $('body').trigger(e);"
        page.driver.execute_script(keypress)
        visit room_path(room)
        expect(page).to have_content "test!"
      end
    end
  end
  
end