class UsersController < ApplicationController
  before_action :set_user, only: [
    :show, :edit, :update, :destroy, :activate, :remove_document
  ]

  # ================= INDEX =================
  # GET /users
  def index
    @users = User.all
  end

  # ================= SHOW =================
  # GET /users/:id
  def show
    @profile = @user.profile
    @addresses = @user.addresses || []
    @orders = @user.orders || []
    @products = @user.products || []
    @wishlists = @user.wishlists || []
    @reviews = @user.reviews || []
    @events = @user.events || []
    @comments = @user.comments || []
    @notifications = @user.notifications || []
    @subscriptions = @user.subscriptions || []
    @support_tickets = @user.support_tickets || []
      @tickets = Ticket.includes(:event).where(user: @user)
    @messages_sent = @user.sent_messages || []
    @messages_received = @user.received_messages || []
  end

  # ================= NEW =================
  # GET /users/new
  def new
    @user = User.new
    @user.build_profile
  end

  # ================= CREATE =================
  # POST /users
def create
  @user = User.new(user_params)

  if @user.save
    redirect_to @user, notice: "User created successfully."
  else
    Rails.logger.debug @user.errors.full_messages
    render :new, status: :unprocessable_entity
  end
end

  # ================= EDIT =================
  # GET /users/:id/edit
  def edit
    @user.build_profile unless @user.profile
  end

  # ================= UPDATE =================
  # PATCH/PUT /users/:id
  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # ================= DESTROY =================
  # DELETE /users/:id
  def destroy
    @user.destroy
    redirect_to users_path, notice: "User deleted successfully."
  end

  # ================= ACTIVATE =================
  # PATCH /users/:id/activate
  def activate
    @user.update(status: :active)
    redirect_to @user, notice: "User activated successfully."
  end

  # ================= REMOVE DOCUMENT =================
  # DELETE /users/:id/remove_document?document_id=xx
  def remove_document
    if params[:document_id].present?
      document = @user.documents.find_by(id: params[:document_id])
      document.purge if document
    end

    redirect_to @user, notice: "Document removed successfully."
  end

  # ================= PRIVATE =================
  private

  def set_user
    @user = User.find(params[:id])
  end
def user_params
  params.require(:user).permit(
    :name,
    :email,
    :role,
    :status,
    :email,
    :password,
    :password_confirmation,
    documents: [],
    profile_attributes: [
      :id,
      :phone,
      :bio,
      :address,
      :_destroy,
      images: []     
    ]
  )
end

end
