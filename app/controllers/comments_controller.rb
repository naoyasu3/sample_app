class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def create
    micropost = Micropost.find(params[:micropost_id])
    @comment = micropost.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "投稿しました！"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "投稿に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end
