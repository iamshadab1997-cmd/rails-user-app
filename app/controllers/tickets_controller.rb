class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :update, :destroy]

  # GET /tickets
  def index
    tickets = Ticket.all
    render json: {
      status: "success",
      count: tickets.size,
      data: tickets
    }, status: :ok
  end

  # GET /tickets/:id
  def show
    render json: {
      status: "success",
      data: @ticket
    }, status: :ok
  end

  # POST /tickets
  def create
    ticket = Ticket.new(ticket_params)

    if ticket.save
      render json: {
        status: "success",
        message: "Ticket created successfully",
        data: ticket
      }, status: :created
    else
      render json: {
        status: "error",
        errors: ticket.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tickets/:id
  def update
    if @ticket.update(ticket_params)
      render json: {
        status: "success",
        message: "Ticket updated successfully",
        data: @ticket
      }, status: :ok
    else
      render json: {
        status: "error",
        errors: @ticket.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # DELETE /tickets/:id
  def destroy
    @ticket.destroy
    render json: {
      status: "success",
      message: "Ticket deleted successfully"
    }, status: :ok
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {
      status: "error",
      message: "Ticket not found"
    }, status: :not_found
  end

  def ticket_params
    params.require(:ticket).permit(:event_id, :price)
  end
end
