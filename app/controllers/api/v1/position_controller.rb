module Api
  module V1
    class PositionController < ApiController
      def update
        task = authorize Task.find(params[:task_id])

        task.insert_at(params['data']['attributes']['position'].to_i)
        jsonapi_render json: task, status: :created
      end
    end
  end
end
