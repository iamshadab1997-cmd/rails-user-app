class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :update, :destroy]

  # GET /subscriptions
  def index
    subscriptions = Subscription.all
    render json: { status: "success", data: subscriptions }, status: :ok
  end

  # GET /subscriptions/:id
  def show
    render json: { status: "success", data: @subscription }, status: :ok
  end

  # POST /subscriptions
  def create
    subscription = Subscription.new(subscription_params)

    if subscription.save
      render json: { status: "success", message: "Subscription created successfully", data: subscription }, status: :created
    else
      render json: { status: "error", errors: subscription.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /subscriptions/:id
  def update
    if @subscription.update(subscription_params)
      render json: { status: "success", message: "Subscription updated successfully", data: @subscription }, status: :ok
    else
      render json: { status: "error", errors: @subscription.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /subscriptions/:id
  def destroy
    @subscription.destroy
    render json: { status: "success", message: "Subscription deleted successfully" }, status: :ok
  end

  private

  def set_subscription
    @subscription = Subscription.find_by(id: params[:id])
    render json: { status: "error", message: "Subscription not found" }, status: :not_found unless @subscription
  end

  # ✅ Use plan_name, not plan
  def subscription_params
    params.require(:subscription).permit(:user_id, :plan_name)
  end
end
