class RepliesController < ApplicationController
  before_action :set_reply
  def create
    authorize @reply
    flash[:alert] = @reply.errors.full_messages.to_sentence unless @reply.save
    redirect_to suggestion_path(params[:suggestion_id])
  end

  private

  def set_reply
    @reply = current_user.replies.new(reply_params)
  end

  def reply_params
    params.require(:reply).permit(:body).merge(suggestion_id: params[:suggestion_id])
  end
end
