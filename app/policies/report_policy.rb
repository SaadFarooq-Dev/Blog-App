class ReportPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    if @record.reportable.instance_of?(Post)
      @record.reportable.status == 'approved'
    else
      @record.reportable.instance_of?(Comment)
    end
  end

  def index?
    %w[moderator admin].include?(@user.role)
  end

  def show?
    index?
  end

  def destroy?
    index?
  end
end
