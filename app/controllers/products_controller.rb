class ProductsController < ApplicationController
  before_action :set_user
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]

  def index
    @products = @user.products
  end

  def show
  end

  def new
    @product = @user.products.new
  end

  def create
    @product = @user.products.new(product_params)

    if @product.save
      redirect_to [ @user, @product ], notice: "Product created successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to [ @user, @product ], notice: "Product updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to user_products_path(@user), notice: "Product deleted successfully"
  end

  def search
    @products = @user.products.where("name ILIKE ?", "%#{params[:q]}%")
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_product
    @product = @user.products.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :stock, images: [])
  end
end
