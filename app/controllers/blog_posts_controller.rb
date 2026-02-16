class BlogPostsController < ApplicationController
  before_action :set_blog_post, only: [ :show, :update, :destroy ]

  # GET /blog_posts
  def index
    blog_posts = BlogPost.page(params[:page]).per(10) # Kaminari pagination
    render json: {
      status: "success",
      data: BlogPostSerializer.new(blog_posts).serializable_hash,
      meta: {
        current_page: blog_posts.current_page,
        total_pages: blog_posts.total_pages,
        total_count: blog_posts.total_count
      }
    }, status: :ok
  end

  # GET /blog_posts/:id
  def show
    render json: {
      status: "success",
      data: BlogPostSerializer.new(@blog_post).serializable_hash
    }, status: :ok
  end

  # POST /blog_posts
  def create
    blog_post = BlogPost.new(blog_post_params)
    if blog_post.save
      render json: {
        status: "success",
        message: "Blog post created successfully",
        data: BlogPostSerializer.new(blog_post).serializable_hash
      }, status: :created
    else
      render json: {
        status: "error",
        errors: blog_post.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /blog_posts/:id
  def update
    if @blog_post.update(blog_post_params)
      render json: {
        status: "success",
        message: "Blog post updated successfully",
        data: BlogPostSerializer.new(@blog_post).serializable_hash
      }, status: :ok
    else
      render json: {
        status: "error",
        errors: @blog_post.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # DELETE /blog_posts/:id
  def destroy
    @blog_post.destroy
    render json: {
      status: "success",
      message: "Blog post deleted successfully"
    }, status: :ok
  end

  private

  # Find blog post or return 404
  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {
      status: "error",
      errors: [ "Blog post not found" ]
    }, status: :not_found
  end

  # Strong parameters
  def blog_post_params
    params.require(:blog_post).permit(:title, :content, :user_id, :image)
  end
end
