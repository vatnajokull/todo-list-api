class TaskPolicy < ApplicationPolicy
  def show?
    owner?
  end

  def create?
    owner?
  end

  def update?
    owner?
  end

  def change_position?
    owner?
  end

  def destroy?
    owner?
  end

  class Scope < Scope
    def resolve
      scope.includes(:project).where(projects: { user: user })
    end
  end

  private

  def owner?
    record.project.user == user
  end
end
