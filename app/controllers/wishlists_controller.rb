class WishlistsController < ApplicationController
  before_action :set_wishlist, only: [ :show, :update, :destroy ]

  # GET /wishlists
  def index
    wishlists = Wishlist.page(params[:page]).per(10)

    render json: {
      status: "success",
      data: WishlistSerializer.new(wishlists).serializable_hash[:data],
      meta: {
        current_page: wishlists.current_page,
        total_pages: wishlists.total_pages,
        total_count: wishlists.total_count
      }
    }, status: :ok
  end

  # GET /wishlists/:id
  def show
    render json: {
      status: "success",
      data: WishlistSerializer.new(@wishlist).serializable_hash[:data]
    }, status: :ok
  end

  # POST /wishlists
  def create
    wishlist = Wishlist.new(wishlist_params)

    if wishlist.save
      render json: {
        status: "success",
        data: WishlistSerializer.new(wishlist).serializable_hash[:data]
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
        data: WishlistSerializer.new(@wishlist).serializable_hash[:data]
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
      errors: [ "Wishlist not found" ]
    }, status: :not_found
  end

  def wishlist_params
    params.require(:wishlist).permit(:user_id, :name)
  end
end
