# frozen_string_literal: true

module Api::Rendering
  extend ActiveSupport::Concern

  def render_success(data: {})
    data_response = opts[:data] || {}

    render json: data_response, status: :ok
  end
end