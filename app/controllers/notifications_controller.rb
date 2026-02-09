class NotificationsController < ApplicationController
  def index; @notifications = Notification.all end
  def show; @notification = Notification.find(params[:id]) end
  def new; @notification = Notification.new end

  def create
    @notification = Notification.new(notification_params)
    redirect_to @notification if @notification.save
  end

  def edit; @notification = Notification.find(params[:id]) end

  def update
    @notification = Notification.find(params[:id])
    redirect_to @notification if @notification.update(notification_params)
  end

  def destroy
    Notification.find(params[:id]).destroy
    redirect_to notifications_path
  end

  private
  def notification_params
    params.require(:notification).permit(:user_id, :message)
  end
end
