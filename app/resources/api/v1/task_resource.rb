module Api
  module V1
    class TaskResource < JSONAPI::Resource
      attributes :name, :due_date
    end
  end
end
