module Api
  module V1
    class ProjectsController < ApiController
      def index
        jsonapi_render json: policy_scope(Project).all
      end

      def show
        project = authorize Project.find(params[:id])

        jsonapi_render json: project
      end

      def create
        project = authorize Project.new(resource_params.merge(user: current_user))

        if project.save
          jsonapi_render json: project, status: :created
        else
          jsonapi_render_errors json: project, status: :unprocessable_entity
        end
      end

      def update
        project = authorize Project.find(params[:id])

        if project.update(resource_params)
          jsonapi_render json: project, status: :created
        else
          jsonapi_render_errors json: project, status: :unprocessable_entity
        end
      end

      def destroy
        project = authorize Project.find(params[:id])

        project.destroy
      end
    end
  end
end
