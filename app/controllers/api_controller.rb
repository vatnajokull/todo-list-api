class ApiController < ApplicationController
  before_action :authenticate_user!

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  include JSONAPI::Utils

  rescue_from ActiveRecord::RecordNotFound, with: :jsonapi_render_not_found
end
