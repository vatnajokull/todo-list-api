module Api
  module V1
    class TasksController < ApiController
      def index
        jsonapi_render json: policy_scope(Task).all
      end

      def show
        task = authorize Task.find(params[:id])

        jsonapi_render json: task
      end

      def create
        task = authorize Task.new(resource_params.merge(project_id: params[:project_id]))

        if task.save
          jsonapi_render json: task, status: :created
        else
          jsonapi_render_errors json: task, status: :unprocessable_entity
        end
      end

      def update
        task = authorize Task.find(params[:id])

        if task.update(resource_params)
          jsonapi_render json: task, status: :created
        else
          jsonapi_render_errors json: task, status: :unprocessable_entity
        end
      end

      def change_position
        task = authorize Task.find(params[:id])

        if task.change_position(params[:direction].to_sym)
          jsonapi_render json: policy_scope(Task).all, status: :ok
        else
          jsonapi_render_errors json: task, status: :unprocessable_entity
        end
      end

      def destroy
        task = authorize Task.find(params[:id])

        task.destroy
      end
    end
  end
end
