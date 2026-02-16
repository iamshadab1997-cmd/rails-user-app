class CommentsController < ApplicationController
 before_action :set_cart, only: [ :show, :edit, :update, :destroy ]


def index
  @comments = Comment.limit(10) # simple pagination, optional

  render json: {
    status: "success",
    total_count: @comments.count,
    data: @comments.map do |c|
      {
        id: c.id,
        body: c.body,
        author_name: c.author_name,
        email: c.email,
        approved: c.approved,
        commentable_type: c.commentable_type,
        commentable_id: c.commentable_id,
        created_at: c.created_at,
        updated_at: c.updated_at
      }
    end
  }, status: :ok
end


  # GET /comments/:id
  def show
    render json: {
      status: "success",
      data: CommentSerializer.new(@comment)
    }, status: :ok
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: {
        status: "success",
        message: "Comment created successfully",
        data: CommentSerializer.new(@comment)
      }, status: :created
    else
      render json: {
        status: "error",
        errors: @comment.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/:id
  def update
    if @comment.update(comment_params)
      render json: {
        status: "success",
        message: "Comment updated successfully",
        data: CommentSerializer.new(@comment)
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

  # Set comment
  def set_comment
    @comment = Comment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {
      status: "error",
      message: "Comment not found"
    }, status: :not_found
  end

  # Strong params
  def comment_params
    params.require(:comment).permit(:user_id, :commentable_id, :commentable_type, :body)
  end
end
