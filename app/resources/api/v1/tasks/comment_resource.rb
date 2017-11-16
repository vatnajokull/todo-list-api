module Api
  module V1
    module Tasks
      class CommentResource < JSONAPI::Resource
        attributes :body
      end
    end
  end
end
