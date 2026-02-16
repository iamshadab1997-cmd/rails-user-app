class EventsController < ApplicationController
before_action :set_cart, only: [ :show, :edit, :update, :destroy ]


  # GET /events
  def index
    events = Event.all
    render json: { status: "success", data: events }, status: :ok
  end

  # GET /events/:id
  def show
    render json: { status: "success", data: @event }, status: :ok
  end

  # POST /events
  def create
    event = Event.new(event_params)
    if event.save
      render json: { status: "success", message: "Event created successfully", data: event }, status: :created
    else
      render json: { status: "error", errors: event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/:id
  def update
    if @event.update(event_params)
      render json: { status: "success", message: "Event updated successfully", data: @event }, status: :ok
    else
      render json: { status: "error", errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /events/:id
  def destroy
    @event.destroy
    render json: { status: "success", message: "Event deleted successfully" }, status: :ok
  end

  private

  # Set event for show/update/destroy
  def set_event
    @event = Event.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { status: "error", message: "Event not found" }, status: :not_found
  end

  # Strong parameters
  def event_params
    params.require(:event).permit(:title, :start_time)
  end
end
