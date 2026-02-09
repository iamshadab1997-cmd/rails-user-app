class MessagesController < ApplicationController
  def index; @messages = Message.all end
  def show; @message = Message.find(params[:id]) end
  def new; @message = Message.new end

  def create
    @message = Message.new(message_params)
    redirect_to @message if @message.save
  end

  def edit; @message = Message.find(params[:id]) end

  def update
    @message = Message.find(params[:id])
    redirect_to @message if @message.update(message_params)
  end

  def destroy
    Message.find(params[:id]).destroy
    redirect_to messages_path
  end

  private
  def message_params
    params.require(:message).permit(:sender_id, :receiver_id, :body)
  end
end
