class Api::V1::PostController < ApplicationController
  before_action :set_post, only: %i[show]
  skip_before_action :authenticate_user!, only: %i[index show]
  def index
    @posts = Post.includes(:user).approved_posts
    render json: @posts
    # render json: @posts.collect { |b| b.attributes_with_username_flag(b) }
  end

  def show
    @post = Post.find(params[:id])
    authorize @post, policy_class: PostPolicy
    render json: @post
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
