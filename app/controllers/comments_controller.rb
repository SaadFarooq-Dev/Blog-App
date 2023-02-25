class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    authorize(@comment)
    @post = @comment.post
    respond_to do |format|
      if @comment.save!
        format.html { redirect_to post_path(params[:post_id]) }
        format.js { render 'create.js.erb' }
      else
        flash[:notice] = @comment.errors.full_messages.to_sentence

        format.html { redirect_back(fallback_location: root_path) }
        format.js
      end
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    if @comment.destroy
      redirect_to reports_url, notice: 'Comment was successfully destroyed.'
    else
      flash[:notice] = @comment.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id, :image).merge(post_id: params[:post_id])
  end
end
