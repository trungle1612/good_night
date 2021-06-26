# frozen_string_literal: true

class Api::V1::SessionsController < Doorkeeper::TokensController
  def create
    super

    response_json = JSON.parse(response.body)
    @_response_body = nil

    if status == 200
      render json: {
        access_token: response_json['access_token']
      }, status: :ok
    else
      render json: {
        error: response_json['error'],
        message: response_json['error_description']
      }, status: :unauthorized
    end
  end
end
