module Api
  module V1
    module Auth
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        skip_before_action :validate_sign_up_params

        # protected

        # def render_create_success
        # end

        # def render_create_error
        # end
      end
    end
  end
end
