module Api
  module V1
    module Tasks
      class PositionController < ApplicationController
        def update
          task = authorize Task.find(params[:task_id])

          task.insert_at(params[:position].to_i)
        end
      end
    end
  end
end
