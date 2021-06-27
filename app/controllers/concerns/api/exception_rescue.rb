# frozen_string_literal: true

module Api::ExceptionRescue
  extend ActiveSupport::Concern

  included do # rubocop:disable Metrics/BlockLength
    rescue_from ActionController::ParameterMissing do |ex|
      render_400(Error::ParameterMissing.new(400, ex.message))
    end

    rescue_from Api::Errors::ParameterMissing, Api::Errors::BadRequest, with: :render_400
    rescue_from Api::Errors::Unauthorized, Api::Errors::InvalidToken, with: :render_401

    rescue_from ActiveRecord::RecordNotFound,
                Api::Errors::ResourceNotFound do |ex|
      render_404(Error::ResourceNotFound.new(404, ex.message))
    end

    rescue_from Api::Errors::ResourceNotUnique,
                ActiveRecord::RecordNotUnique do |ex|
      render_409(Error::ResourceNotUnique.new(409, ex.message))
    end

    rescue_from ActiveRecord::RecordInvalid do |ex|
      render_422(Error::RecordInvalid.new(
                   422,
          ex.record.errors.full_messages.first
                 ))
    end

    rescue_from ActiveRecord::InvalidForeignKey do |ex|
      render_422(Error::RecordInvalid.new(409, ex.message))
    end

    rescue_from Api::Errors::RecordInvalid, with: :render_422

    def render_400(ex)
      handle_response(ex, status: :bad_request)
    end

    def render_404(ex)
      handle_response(ex, status: :not_found)
    end

    def render_409(ex)
      handle_response(ex, status: :conflict)
    end

    def render_422(ex)
      handle_response(ex, status: :unprocessable_entity)
    end

    private
    def handle_response(ex, status:)
      render json: ex.as_json, status: status
    end
  end
end
