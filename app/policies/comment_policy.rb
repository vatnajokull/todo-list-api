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
      scope.includes(:project, :task).where("task_id IN (?)", user.projects.map { |project| project.tasks.ids }.flatten!)
    end
  end

  private

  def owner?
    record.task.project.user == user
  end
end
