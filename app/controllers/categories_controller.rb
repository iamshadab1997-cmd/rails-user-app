class CategoriesController < ApplicationController
  def index; @categories = Category.all end
  def show; @category = Category.find(params[:id]) end
  def new; @category = Category.new end

  def create
    @category = Category.new(category_params)
    redirect_to @category if @category.save
  end

  def edit; @category = Category.find(params[:id]) end

  def update
    @category = Category.find(params[:id])
    redirect_to @category if @category.update(category_params)
  end

  def destroy
    Category.find(params[:id]).destroy
    redirect_to categories_path
  end

  private
  def category_params
    params.require(:category).permit(:title)
  end
end
