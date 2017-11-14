Rails.application.routes.draw do
  devise_for :users, skip: %i[registrations sessions confirmations passwords invitations omniauth_callbacks]

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for User.name,
                                  at: 'auth',
                                  controllers: {
                                    registrations: 'api/v1/auth/registrations',
                                    sessions: 'api/v1/auth/sessions',
                                    token_validations: 'api/v1/auth/token_validations'
                                  },
                                  skip: %i[passwords invitations omniauth_callbacks]

      jsonapi_resources :projects, only: %i[index show create update destroy], shallow: true do
        jsonapi_resources :tasks, only: %i[index show create update destroy] do
          jsonapi_resources :comments, only: %i[index create destroy]
          member do
            get :change_position
          end
        end
      end
    end
  end

  get '/', to: redirect('/apidoc')
end
