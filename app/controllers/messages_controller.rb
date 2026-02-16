class MessagesController < ApplicationController
  # ================= FILTERS =================

  # Authentication stub (runs for all except index & show)
  before_action :authenticate_user_stub, except: [ :index, :show ]

  # Load resource before specific actions
  before_action :set_message, only: [ :show, :update, :destroy, :force_update ]

  # Authorization check (multiple filters chain)
  before_action :authorize_user_stub, only: [ :update, :destroy ]

  # After action logging
  after_action :log_action

  # Around action for performance tracking
  around_action :measure_execution_time

  # ================= ACTIONS (PUBLIC METHODS) =================

  # GET /messages
  def index
    @messages = Message.order(created_at: :desc)
                       .page(params[:page])
                       .per(10)

    respond_to do |format|
      format.html { render :index }  # HTML rendering
      format.json do
        render json: @messages,
               meta: {
                 current_page: @messages.current_page,
                 total_pages: @messages.total_pages,
                 total_count: @messages.total_count
               },
               status: :ok
      end
    end
  end

  # GET /messages/:id
  def show
    render json: @message, status: :ok
  end

  # POST /messages
  def create
    @message = Message.new(message_params)

    # NON-BANG METHOD
    if @message.save
      render json: @message, status: :created
    else
      render json: { errors: @message.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/:id
  def update
    # BANG METHOD (demonstration)
    begin
      @message.update!(message_params)
      render json: @message, status: :ok
    rescue ActiveRecord::RecordInvalid => e
      render json: { errors: e.record.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PATCH /messages/:id/force_update
  # Demonstrates bypassing validations
  def force_update
    # ⚠ Skips validations and callbacks (use carefully in real apps)
    @message.update_column(:body, "Force updated message")
    render json: { message: "Updated without validations" }, status: :ok
  end

  # DELETE /messages/:id
  def destroy
    @message.destroy
    render json: { message: "Message deleted successfully" }, status: :ok
  end

  # ================= PRIVATE METHODS =================
  private


  def set_message
    @message = Message.find_by(id: params[:id])
    unless @message
      render json: { errors: [ "Message not found" ] }, status: :not_found
    end
  end

  # 🔹 Strong params (only permitted fields allowed)
  def message_params
    permitted = params.require(:message).permit(:sender_id, :receiver_id, :body)

    # Example: If user sends extra param like :admin => true
    # It will be ignored automatically by strong params.
    permitted
  end

  # 🔹 Authentication stub (demo purpose)
  def authenticate_user_stub
    # Example stub (replace with real auth)
    unless request.headers["X-USER-ID"]
      render json: { errors: [ "Unauthorized" ] }, status: :unauthorized
    end
  end

  # 🔹 Authorization stub
  def authorize_user_stub
    # Dummy authorization example
    unless @message.sender_id.to_s == request.headers["X-USER-ID"]
      render json: { errors: [ "Forbidden" ] }, status: :forbidden
    end
  end

  # 🔹 After action logging
  def log_action
    Rails.logger.info "Action #{action_name} performed at #{Time.current}"
  end

  # 🔹 Around action example
  def measure_execution_time
    start_time = Time.current
    yield
    end_time = Time.current
    Rails.logger.info "Execution time: #{end_time - start_time} seconds"
  end
end
