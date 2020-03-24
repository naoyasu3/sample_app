require 'rails_helper'

RSpec.describe "CommentsSpec", type: :system do
  let(:user){ FactoryBot.create(:user) }
  let!(:micropost){ FactoryBot.create(:micropost, user: user) }
  let!(:comment){ FactoryBot.create(:comment, user: user, micropost: micropost) }

  describe "comment RSpec" do
    context '正常系' do
      before do
        log_in_as user
      end

      it 'コメントを投稿した場合' do
        visit micropost_path(micropost)
        fill_in "comment_content",	with: "sometext" 
        click_button 'コメントする！'
        expect(page).to have_selector('.alert-success', text: '投稿しました！')
      end
      it 'コメント削除した場合' do
        visit micropost_path(micropost)
        find(".comment-delete-#{comment.id}").click
        expect(page).to have_selector('.alert-success', text: 'Comment delete')
      end
    end

    context '異常系' do
      it '144文字以上入力した場合' do
        log_in_as user
        visit micropost_path(micropost)
        fill_in "comment_content",	with: "a" * 145
        click_button 'コメントする！'
        expect(page).to have_selector('.alert-danger', text: '投稿に失敗しました')
      end
    end
  end
  
end