class PaymentsController < ApplicationController
  def index; @payments = Payment.all end
  def show; @payment = Payment.find(params[:id]) end
  def new; @payment = Payment.new end

  def create
    @payment = Payment.new(payment_params)
    redirect_to @payment if @payment.save
  end

  def edit; @payment = Payment.find(params[:id]) end

  def update
    @payment = Payment.find(params[:id])
    redirect_to @payment if @payment.update(payment_params)
  end

  def destroy
    Payment.find(params[:id]).destroy
    redirect_to payments_path
  end

  private
  def payment_params
    params.require(:payment).permit(:order_id, :amount)
  end
end
