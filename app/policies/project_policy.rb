class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user).order(created_at: :desc)
    end
  end

  def show?
    record.user == user || user.admin
  end

  def new?
    true
  end

  def create?
    user.verified?
  end

  def canceled?
    record.user == user && record.sent?
  end

  def confirmation?
    record.user == user || user.admin
  end

  def promo_code?
    record.user == user || user.admin
  end

  def sending?
    record.user == user || user.admin
  end
end
