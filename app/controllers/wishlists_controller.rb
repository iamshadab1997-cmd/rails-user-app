class WishlistsController < ApplicationController
  before_action :set_wishlist, only: [:show, :update, :destroy]

  # GET /wishlists
  def index
    wishlists = Wishlist.all

    render json: {
      status: "success",
      data: wishlists
    }, status: :ok
  end

  # GET /wishlists/:id
  def show
    render json: {
      status: "success",
      data: @wishlist
    }, status: :ok
  end

  # POST /wishlists
  def create
    wishlist = Wishlist.new(wishlist_params)

    if wishlist.save
      render json: {
        status: "success",
        message: "Wishlist created successfully",
        data: wishlist
      }, status: :created
    else
      render json: {
        status: "error",
        errors: wishlist.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /wishlists/:id
  def update
    if @wishlist.update(wishlist_params)
      render json: {
        status: "success",
        message: "Wishlist updated successfully",
        data: @wishlist
      }, status: :ok
    else
      render json: {
        status: "error",
        errors: @wishlist.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # DELETE /wishlists/:id
  def destroy
    @wishlist.destroy

    render json: {
      status: "success",
      message: "Wishlist deleted successfully"
    }, status: :ok
  end

  private

  def set_wishlist
    @wishlist = Wishlist.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {
      status: "error",
      message: "Wishlist not found"
    }, status: :not_found
  end

  def wishlist_params
    params.require(:wishlist).permit(:user_id, :name)
  end
end
