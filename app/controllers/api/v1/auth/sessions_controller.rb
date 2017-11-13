module Api
  module V1
    module Auth
      class SessionsController < DeviseTokenAuth::SessionsController
        # protected

        # def render_create_success
        # end

        # def render_create_error_bad_credentials
        # end
      end
    end
  end
end
