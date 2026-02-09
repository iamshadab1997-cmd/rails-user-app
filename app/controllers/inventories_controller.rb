class InventoriesController < ApplicationController
  def index
    @inventories = Inventory.all
  end

  def show
    @inventory = Inventory.find(params[:id])
  end

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = Inventory.new(inventory_params)
    redirect_to @inventory if @inventory.save
  end

  def edit
    @inventory = Inventory.find(params[:id])
  end

  def update
    @inventory = Inventory.find(params[:id])
    redirect_to @inventory if @inventory.update(inventory_params)
  end

  def destroy
    Inventory.find(params[:id]).destroy
    redirect_to inventories_path
  end

  private
  def inventory_params
    params.require(:inventory).permit(:product_id, :quantity)
  end
end
