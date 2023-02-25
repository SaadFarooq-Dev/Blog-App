class ApprovePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    %w[moderator admin].include?(@user.role)
  end

  def show?
    index?
  end

  def update?
    index?
  end
end
