module Api
  module V1
    class CompleteController < ApiController
      def update
        task = authorize(Task.find(params[:task_id]))

        task.update(done: !task.done)

        jsonapi_render json: task, status: :created
      end
    end
  end
end
