# app/controllers/reviews_controller.rb
class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :update, :destroy]

  # GET /reviews
  def index
    reviews = Review.all
    render json: { status: "success", data: reviews }, status: :ok
  end

  # GET /reviews/:id
  def show
    render json: { status: "success", data: @review }, status: :ok
  end

  # POST /reviews
  def create
    review = Review.new(review_params)
    if review.save
      render json: { status: "success", data: review }, status: :created
    else
      render json: { status: "error", errors: review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /reviews/:id
  def update
    if @review.update(review_params)
      render json: { status: "success", data: @review }, status: :ok
    else
      render json: { status: "error", errors: @review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /reviews/:id
  def destroy
    @review.destroy
    render json: { status: "success", message: "Review deleted" }, status: :ok
  end

  private

  def set_review
    @review = Review.find_by(id: params[:id])
    unless @review
      render json: { status: "error", message: "Review not found" }, status: :not_found
    end
  end

  def review_params
    params.require(:review).permit(:user_id, :product_id, :rating, :comment, :approved)
  end
end
