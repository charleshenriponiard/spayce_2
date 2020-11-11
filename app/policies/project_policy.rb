class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def show?
    record.user == user || user.admin
  end

  def new?
    create?
  end

  def create?
    true
  end

  def canceled?
    record.user == user
  end
end
