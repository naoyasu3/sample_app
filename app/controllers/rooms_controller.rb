class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    @room = Room.new
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      flash[:success] = "新しいチャットルームを作成しました"
      redirect_to rooms_path
    else
      flash[:danger] = "失敗しました"
      render 'rooms/index'
    end
  end

  private 
    def room_params
      params.require(:room).permit(:name)
    end
end
