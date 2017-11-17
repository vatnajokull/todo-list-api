module Api
  module V1
    class TaskResource < JSONAPI::Resource
      attributes :name, :due_date, :done, :position, :comments_count

      has_many :comments
    end
  end
end
