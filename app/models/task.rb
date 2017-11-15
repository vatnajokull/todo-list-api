class Task < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :destroy
  acts_as_list scope: :project, top_of_list: 0

  validates :name, presence: true
  validate :due_date_cannot_be_in_the_past, if: :due_date_changed?

  def due_date_cannot_be_in_the_past
    errors.add(:due_date, 'can not be in the past') if due_date.present? && due_date < Time.zone.today
  end
end
