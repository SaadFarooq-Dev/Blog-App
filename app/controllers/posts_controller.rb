class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @posts = Post.includes(:user).approved_posts
  end

  def show
    @post = Post.find(params[:id])
    authorize @post, policy_class: PostPolicy
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params.merge(Published_date: Time.zone.now, user_id: current_user.id))
    if @post.save
      redirect_to post_url(@post), notice: 'Post was successfully created.'
    else
      flash[:notice] = @post.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_url(@post), notice: 'Post was successfully updated.'
    else
      flash[:notice] = @post.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    flash[:notice] = if @post.destroy
                       'Post was successfully destroyed.'
                     else
                       @post.errors.full_messages.to_sentence
                     end
    redirect_to posts_url
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
