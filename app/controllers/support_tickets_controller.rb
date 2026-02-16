class SupportTicketsController < ApplicationController
  before_action :set_support_ticket, only: [ :show, :update, :destroy ]

  def index
    support_tickets = SupportTicket.page(params[:page]).per(10)
    render json: {
      status: "success",
      data: support_tickets.map { |t| SupportTicketSerializer.new(t).serializable_hash[:data][:attributes] },
      meta: {
        current_page: support_tickets.current_page,
        total_pages: support_tickets.total_pages,
        total_count: support_tickets.total_count
      }
    }, status: :ok
  end

  def show
    render json: {
      status: "success",
      data: SupportTicketSerializer.new(@support_ticket).serializable_hash[:data][:attributes]
    }, status: :ok
  end

  def create
    support_ticket = SupportTicket.new(support_ticket_params)

    if support_ticket.save
      render json: {
        status: "success",
        message: "Support ticket created successfully",
        data: SupportTicketSerializer.new(support_ticket).serializable_hash[:data][:attributes]
      }, status: :created
    else
      render json: {
        status: "error",
        errors: support_ticket.errors
      }, status: :unprocessable_entity
    end
  end

  def update
    if @support_ticket.update(support_ticket_params)
      render json: {
        status: "success",
        message: "Support ticket updated successfully",
        data: SupportTicketSerializer.new(@support_ticket).serializable_hash[:data][:attributes]
      }, status: :ok
    else
      render json: {
        status: "error",
        errors: @support_ticket.errors
      }, status: :unprocessable_entity
    end
  end

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
    render json: { status: "error", message: "Support ticket not found" }, status: :not_found
  end

  def support_ticket_params
    params.require(:support_ticket).permit(:user_id, :subject, :description, :status, :priority)
  end
end
