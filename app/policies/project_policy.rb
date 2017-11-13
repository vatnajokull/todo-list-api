class ProjectPolicy < ApplicationPolicy
  def show?
    owner?
  end

  def create?
    owner?
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  private

  def owner?
    record.user == user
  end
end
