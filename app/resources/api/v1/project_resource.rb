module Api
  module V1
    class ProjectResource < JSONAPI::Resource
      attributes :name

      has_one :user
      has_many :tasks
    end
  end
end
