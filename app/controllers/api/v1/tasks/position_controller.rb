module Api
  module V1
    module Tasks
      class PositionController < ApiController
        def update
          task = authorize Task.find(params[:task_id])

          task.insert_at(position_params)
          jsonapi_render json: task, status: :created
        end

        private

        def position_params
          params['data']['attributes']['position'].to_i
        end
      end
    end
  end
end
