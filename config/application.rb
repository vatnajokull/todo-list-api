require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
# require 'sprockets/railtie'
# require 'rails/test_unit/railtie'
require './app/middlewares/catch_json_parse_errors'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TodoListApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.autoload_paths += [config.root.join('app')]

    config.annotations.register_directories('spec')

    config.middleware.use CatchJsonParseErrors

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: %i[get post options]
      end
    end

    config.generators.system_tests = nil

    config.time_zone = 'Kyiv'

    config.generators do |generator|
      generator.template_engine false
      generator.factory_bot true
      generator.factory_bot dir: 'spec/factories'
      generator.test_framework :rspec,
                               fixtures: true,
                               view_specs: false,
                               helper_specs: false,
                               routing_specs: false,
                               request_specs: true,
                               controller_specs: true
    end

    config.i18n.enforce_available_locales = true
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml')]
    config.i18n.default_locale = :en

    I18n.reload!
  end
end
