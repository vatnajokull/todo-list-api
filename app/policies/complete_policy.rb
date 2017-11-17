class CompletePolicy < ApplicationPolicy
  def update?
    owner?
  end

  private

  def owner?
    record.project.user == user
  end
end
