class ApprovesController < ApplicationController
  before_action :pundit_authorization
  before_action :set_post, only: %i[show update]

  def index
    @posts = Post.includes(:user).pending_posts
  end

  def show
    return unless @post.nil?

    flash[:notice] = 'This Post Does Not Exits.'
    redirect_back(fallback_location: root_path)
  end

  def update
    if @post.update(approves_params)
      redirect_to posts_path
    else
      flash[:alert] = @post.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def pundit_authorization
    authorize current_user, policy_class: ApprovePolicy
  end

  def set_post
    @post = Post.find_by(id: params[:id])
  end

  def approves_params
    params.require(:post).permit(:status, :Published_date)
  end
end
