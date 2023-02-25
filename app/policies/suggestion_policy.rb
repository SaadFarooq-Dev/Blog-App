class SuggestionPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def update?
    @record.user_id == @user.id
  end

  def show?
    @record.user_id == @user.id || @record.post.user_id == @user.id
  end

  def destroy?
    @record.post.user_id == @user.id unless @record.nil?
  end
end
