module Api
  module V1
    class TaskResource < JSONAPI::Resource
      attributes :name
    end
  end
end
