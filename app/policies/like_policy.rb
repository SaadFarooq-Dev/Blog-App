class LikePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    if @record.likeable.instance_of?(Post)
      @record.likeable.status == 'approved'
    elsif @record.likeable.instance_of?(Comment)
      true
    end
  end
end
