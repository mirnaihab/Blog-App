class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [ :update, :destroy ]
  # before_action :authorize_user, only: [ :update, :destroy ]

  # POST /posts/:post_id/comments
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/:post_id/comments/:id
  def update
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
      if @comment.update(comment_params)
        render json: @comment
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Not authorized" }, status: :forbidden
    end
  end

  # DELETE /posts/:post_id/comments/:id
  def destroy
    comment = Comment.find(params[:id])
    if comment.user == current_user
      @comment.destroy
      head :no_content
    else
      render json: { error: "Not authorized" }, status: :forbidden
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.permit(:body)
  end
end
