class SupportTicketsController < ApplicationController
  before_action :set_support_ticket, only: [:show, :update, :destroy]

  # GET /support_tickets
  def index
    support_tickets = SupportTicket.all
    render json: {
      status: "success",
      data: support_tickets
    }, status: :ok
  end

  # GET /support_tickets/:id
  def show
    render json: {
      status: "success",
      data: @support_ticket
    }, status: :ok
  end

  # POST /support_tickets
  def create
    support_ticket = SupportTicket.new(support_ticket_params)

    if support_ticket.save
      render json: {
        status: "success",
        message: "Support ticket created successfully",
        data: support_ticket
      }, status: :created
    else
      render json: {
        status: "error",
        errors: support_ticket.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /support_tickets/:id
  def update
    if @support_ticket.update(support_ticket_params)
      render json: {
        status: "success",
        message: "Support ticket updated successfully",
        data: @support_ticket
      }, status: :ok
    else
      render json: {
        status: "error",
        errors: @support_ticket.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # DELETE /support_tickets/:id
  def destroy
    @support_ticket.destroy
    render json: {
      status: "success",
      message: "Support ticket deleted successfully"
    }, status: :ok
  end

  private

  def set_support_ticket
    @support_ticket = SupportTicket.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {
      status: "error",
      message: "Support ticket not found"
    }, status: :not_found
  end

def support_ticket_params
  params.require(:support_ticket).permit(
    :user_id,
    :subject,
    :description,
    :status,
    :priority  
  )
end

end
