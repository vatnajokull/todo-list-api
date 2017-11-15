class PositionPolicy < ApplicationPolicy
  def update?
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
