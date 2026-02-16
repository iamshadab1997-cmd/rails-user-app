class CartsController < ApplicationController
 before_action :set_cart, only: [ :show, :edit, :destroy ]


  # GET /cart
  def show
    unless @cart
      redirect_to root_path, alert: "Your cart is empty."
    end
  end

  # POST /cart/add_item
  def add_item
    @cart = current_user.cart || current_user.create_cart(
      total_items: 0,
      total_price: 0
    )

    item = @cart.cart_items.find_or_initialize_by(
      product_id: params[:product_id]
    )

    item.quantity ||= 0
    item.quantity += 1
    item.save!

    redirect_to cart_path, notice: "Item added to cart"
  end

  # DELETE /cart
  def destroy
    return redirect_to root_path if @cart.nil?

    @cart.destroy
    redirect_to root_path, notice: "Cart deleted successfully."
  end

  private

  def set_cart
    @cart = current_user.cart
  end
end
