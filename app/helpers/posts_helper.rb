module PostsHelper
  def post_user_check(post)
    user_signed_in? && (post.user.id == current_user.id)
  end
end
