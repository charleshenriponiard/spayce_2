class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    true
  end

  def destroy?
    true
  end

  def edit?
    update?
  end

  def update?
    true
  end

  def delete_document?
    true
  end
end
