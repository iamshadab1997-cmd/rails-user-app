class TicketsController < ApplicationController
  before_action :set_ticket, only: [ :show, :update, :destroy ]

  # GET /tickets
  def index
    tickets = Ticket.page(params[:page]).per(5)

    render json: {
      status: "success",
      data: TicketSerializer.new(tickets).serializable_hash[:data],
      meta: {
        current_page: tickets.current_page,
        total_pages: tickets.total_pages,
        total_count: tickets.total_count
      }
    }, status: :ok
  end

  # GET /tickets/:id
  def show
    render json: {
      status: "success",
      data: TicketSerializer.new(@ticket).serializable_hash[:data]
    }, status: :ok
  end

  # POST /tickets
  def create
    ticket = Ticket.new(ticket_params)

    if ticket.save
      render json: {
        status: "success",
        data: TicketSerializer.new(ticket).serializable_hash[:data]
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
        data: TicketSerializer.new(@ticket).serializable_hash[:data]
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
      errors: [ "Ticket not found" ]
    }, status: :not_found
  end

  def ticket_params
    params.require(:ticket).permit(:event_id, :price)
  end
end
