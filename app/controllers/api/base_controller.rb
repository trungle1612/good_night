# frozen_string_literal: true

class Api::BaseController < ActionController::API
  include Api::ExceptionRescue
  before_action :doorkeeper_authorize!

  def current_user
    @current_user ||= User.find_by(id: doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def doorkeeper_unauthorized_render_options(error)
    {
      json: {
        message: error[:error]&.description || 'Unauthorized',
        reason:  error[:error]&.reason || 'invalid_token',
        data:    {}
      }
    }
  end
end
