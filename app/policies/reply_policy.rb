class ReplyPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    @record.suggestion.user_id == @user.id || @record.suggestion.post.user_id == @user.id
  end
end
