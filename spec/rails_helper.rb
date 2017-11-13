ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'

SimpleCov.start 'rails' do
  coverage_dir File.join('doc', 'coverage')

  groups = %w[channels commands controllers decorators features forms
              helpers jobs libs mailers middlewares models policies resources
              queries serializers services tasks uploaders values]

  groups.each { |name| add_group name.capitalize, "/app/#{name}" }

  # Default files
  add_filter 'app/jobs/application_job.rb'
  add_filter 'app/mailers/application_mailer.rb'
  add_filter 'app/channels/application_cable/channel.rb'
  add_filter 'app/channels/application_cable/connection.rb'
  add_filter 'app/policies/application_policy.rb'

  # TODO: Remove when implement that tests
  add_filter 'app/middlewares/catch_json_parse_errors.rb'
  add_filter 'app/controllers/api/v1/auth/token_validations_controller.rb'
  add_filter 'app/controllers/api/v1/users_controller.rb'
  add_filter 'app/controllers/api/v1/auth/registrations_controller.rb'
end

require File.expand_path('../../config/environment', __FILE__)

abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'spec_helper'
require 'swagger_helper'
require 'rspec/rails'
require 'pundit/rspec'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  # Helpers -----------------------------------------------------------------------------------------------------------

  config.include FactoryBot::Syntax::Methods
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include JsonSpec::Helpers

  %i[controller request].each do |type|
    config.include Request::JsonHelpers, type: type
    config.include Response::JsonHelpers, type: type
    config.extend Response::JsonHelpers, type: type
  end

  # Database Cleaner --------------------------------------------------------------------------------------------------

  config.before(:suite) do
    Rails.application.load_tasks
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) { DatabaseCleaner.strategy = :transaction }
  config.before(:each, js: true) { DatabaseCleaner.strategy = :truncation }
  config.before(:each) { DatabaseCleaner.start }
  config.append_after(:each) { DatabaseCleaner.clean }

  # Bullet ------------------------------------------------------------------------------------------------------------

  if Bullet.enable?
    config.before(:each) do
      Bullet.start_request
    end

    config.after(:each) do
      Bullet.perform_out_of_channel_notifications if Bullet.notification?
      Bullet.end_request
    end
  end
end

# Shoulda Matchers ----------------------------------------------------------------------------------------------------

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

# JsonSpec ------------------------------------------------------------------------------------------------------------

JsonSpec.configure do
  exclude_keys 'id', 'created_at', 'updated_at', 'links'
end
