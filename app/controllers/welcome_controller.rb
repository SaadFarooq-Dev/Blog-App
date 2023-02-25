class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @posts = Post.includes(:user).approved_posts
    @comments = Comment.includes(:post).includes(:user)
    @likes = Like.includes(:likeable).includes(:user)
  end
end
