# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [ :show, :update, :destroy, :update_Post_tags ]

  # GET /posts
  def index
    @posts = Post.all
    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end


  # PATCH/PUT /posts/1
  def update
    post = Post.find(params[:id])
    if post.user_id == current_user.id
      if @post.update(post_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Not authorized" }, status: :forbidden
    end
  end

   # PATCH/PUT /posts/1
   def update_Post_tags
    post = Post.find(params[:id])
    if post.user_id == current_user.id
      if @post.update(tags_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Not authorized" }, status: :forbidden
    end
  end
  # def update
  #   if @post.author == current_user
  #     if @post.update(post_params)
  #       render json: @post
  #     else
  #       render json: @post.errors, status: :unprocessable_entity
  #     end
  #   else
  #     render json: { error: "Not authorized" }, status: :forbidden
  #   end
  # end
  # def update
  #   post = Post.find(params[:id])
  #   if post.user_id == current_user.id
  #     # Update the post
  #   else
  #     # Forbidden
  #   end
  # end

  # DELETE /posts/1
  def destroy
    post = Post.find(params[:id])
    if post.user_id == current_user.id
      @post.destroy
      head :no_content
    else
      render json: { error: "Not authorized" }, status: :forbidden
    end
  end



  private

  def set_post
    @post = Post.find(params[:id])
  end

   def post_params
    params.permit(:title, :body, tags: [])
  end
  def tags_params
    params.permit(tags: [])
  end
end
