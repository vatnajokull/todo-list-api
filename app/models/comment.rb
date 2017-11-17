class Comment < ApplicationRecord
  include ImageUploader[:image]
  belongs_to :task, counter_cache: true

  validates :body, presence: true
  validates :body, length: { in: 10..256 }
end
