class LikesController < ApplicationController
  before_action :set_like
  def create
    authorize(@like)
    @likeable = set_likeable
    if @like.save!
      render 'create.js.erb'
    else
      flash[:alert] = @like.errors.full_messages.to_sentence
    end
  end

  def destroy
    @likeable = set_likeable
    if @like.destroy!
      render 'create.js.erb'
    else
      flash[:alert] = @like.errors.full_messages.to_sentence
    end
  end

  private

  def set_likeable
    if @like.likeable_type == 'Post'
      Post.find_by(id: @like.likeable_id)
    else
      Comment.find_by(id: @like.likeable_id)
    end
  end

  def set_like
    @like = if action_name == 'create'
              current_user.likes.new(like_params)
            else
              current_user.likes.find_by(id: params[:id])
            end
  end

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
