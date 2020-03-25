class RoomsController < ApplicationController
  def index
  end

  def show
    @messages = Message.all
    @room = Room.find(params[:id])
  end
end
