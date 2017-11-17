class CommentPolicy < ApplicationPolicy
  def index?
    owner?
  end

  def create?
    owner?
  end

  def destroy?
    owner?
  end

  class Scope < Scope
    def resolve
      scope.joins(task: :project).where(projects: { user_id: user })
    end
  end

  private

  def owner?
    record.task.project.user == user
  end
end
