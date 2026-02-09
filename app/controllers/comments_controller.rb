class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]

  # GET /comments
  def index
    comments = Comment.all
    render json: {
      status: "success",
      data: comments
    }, status: :ok
  end

  # GET /comments/:id
  def show
    render json: {
      status: "success",
      data: @comment
    }, status: :ok
  end

  # POST /comments
  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: {
        status: "success",
        message: "Comment created successfully",
        data: comment
      }, status: :created
    else
      render json: {
        status: "error",
        errors: comment.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/:id
  def update
    if @comment.update(comment_params)
      render json: {
        status: "success",
        message: "Comment updated successfully",
        data: @comment
      }, status: :ok
    else
      render json: {
        status: "error",
        errors: @comment.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # DELETE /comments/:id
  def destroy
    @comment.destroy
    render json: {
      status: "success",
      message: "Comment deleted successfully"
    }, status: :ok
  end

  private

  # Set comment for show, update, destroy
  def set_comment
    @comment = Comment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {
      status: "error",
      message: "Comment not found"
    }, status: :not_found
  end

  # Strong parameters
  def comment_params
    params.require(:comment).permit(:user_id, :commentable_id, :commentable_type, :body)
  end
end




