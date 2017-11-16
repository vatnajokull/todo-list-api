module Api
  module V1
    module Tasks
      class CommentResource < JSONAPI::Resource
        attributes :body, :image
      end
    end
  end
end
