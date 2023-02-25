module ApplicationHelper
  def user_moderator?
    current_user.role == 'moderator' if user_signed_in?
  end

  def user_admin?
    current_user.role == 'admin' if user_signed_in?
  end
end
