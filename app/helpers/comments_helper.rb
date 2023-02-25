module CommentsHelper
  def includes_user_comments(comment)
    Comment.all.includes(:user).find_by(id: comment.id)
  end
end
