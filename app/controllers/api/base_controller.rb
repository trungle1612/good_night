# frozen_string_literal: true

class Api::BaseController < ActionController::API
  include Api::Rendering
  include Api::ExceptionRescue
  before_action :doorkeeper_authorize!

  def current_user
    @current_user ||= User.find_by(id: doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end