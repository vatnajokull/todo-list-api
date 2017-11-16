module Api
  module V1
    module Tasks
      class CommentsController < ApiController
        def index
          task = Task.find(params[:task_id])

          jsonapi_render json: policy_scope(Comment).where(task: task)
        end

        def create
          comment = authorize(Comment.new(resource_params.merge(task_id: params[:task_id])))

          if comment.save
            jsonapi_render json: comment, status: :created
          else
            jsonapi_render_errors json: comment, status: :unprocessable_entity
          end
        end

        def destroy
          comment = authorize(Comment.find(params[:id]))

          comment.destroy
        end
      end
    end
  end
end
