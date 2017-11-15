class Task < ApplicationRecord
  belongs_to :project

  validates :name, presence: true
  validate :due_date_cannot_be_in_the_past, if: :due_date_changed?

  private

  def due_date_cannot_be_in_the_past
    errors.add(:due_date, I18n.t('task.validation.due_date_error')) if due_date.present? && due_date < Time.zone.today
  end
end
