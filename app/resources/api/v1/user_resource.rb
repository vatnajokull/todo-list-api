module Api
  module V1
    class UserResource < JSONAPI::Resource
      attributes :email

      has_many :projects
    end
  end
end
