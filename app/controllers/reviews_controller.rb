class ReviewsController < ApplicationController
  before_action :set_review, only: [ :show, :update, :destroy ]

  # ---------------- GET /reviews ----------------
  def index
    reviews = Review.page(params[:page]).per(10)

    render json: {
      status: "success",
      data: serialized_data(reviews),
      meta: pagination_meta(reviews)
    }, status: :ok
  end

  # ---------------- GET /reviews/:id ----------------
  def show
    render json: {
      status: "success",
      data: serialized_data(@review)
    }, status: :ok
  end

  # ---------------- POST /reviews ----------------
  def create
    review = Review.new(review_params)

    if review.save
      render json: {
        status: "success",
        data: serialized_data(review),
        message: "Review created successfully"
      }, status: :created
    else
      render json: {
        status: "error",
        errors: review.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # ---------------- PATCH/PUT /reviews/:id ----------------
  def update
    if @review.update(review_params)
      render json: {
        status: "success",
        data: serialized_data(@review),
        message: "Review updated successfully"
      }, status: :ok
    else
      render json: {
        status: "error",
        errors: @review.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # ---------------- DELETE /reviews/:id ----------------
  def destroy
    @review.destroy

    render json: {
      status: "success",
      message: "Review deleted successfully"
    }, status: :ok
  end

  private

  # ---------------- CALLBACK ----------------
  def set_review
    @review = Review.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {
      status: "error",
      errors: [ "Review not found" ]
    }, status: :not_found
  end

  # ---------------- STRONG PARAMS (FIXED) ----------------
  def review_params
    params.require(:review).permit(
      :user_id,
      :product_id,
      :rating,
      :title,           # ✅ added
      :reviewer_name,   # ✅ added
      :comment,
      :approved
    )
  end

  # ---------------- SERIALIZER HELPER ----------------
  def serialized_data(resource)
    ReviewSerializer.new(resource).serializable_hash[:data]
  end

  # ---------------- PAGINATION META ----------------
  def pagination_meta(collection)
    {
      current_page: collection.current_page,
      total_pages: collection.total_pages,
      total_count: collection.total_count,
      per_page: collection.limit_value
    }
  end
end
