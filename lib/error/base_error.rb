# frozen_string_literal: true

module Error
  class BaseError < StandardError
    attr_accessor :message, :reason

    def initialize(reason = nil, message = nil)
      @reason = reason || default_reason
      @message = message
      super(message)
    end

    def as_json
      {
        success:    false,
        message:    message,
        error_code: @reason,
        data:       {}
      }
    end

    private
    def default_reason
      self.class.name.split('::').last
    end
  end

  class ResourceNotUnique < BaseError; end

  class ResourceNotFound < BaseError; end

  class InternalServerError < BaseError; end

  class RecordInvalid < BaseError; end

  class ParameterMissing < BaseError; end
end
