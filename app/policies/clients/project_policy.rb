class Clients::ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  def show?
    true
  end

  def create_checkout_session?
    true
  end
end
