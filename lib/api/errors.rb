# frozen_string_literal: true

module Api::Errors
  class InvalidToken < Error::BaseError; end

  class ResourceNotFound < Error::BaseError; end

  class BadRequest < Error::BaseError; end

  class RecordNotUnique < Error::BaseError; end

  class ParameterMissing < Error::BaseError; end

  class Unauthorized < Error::BaseError; end

  class Forbidden < Error::BaseError; end

  class ResourceNotUnique < Error::BaseError; end

  class RecordInvalid < Error::BaseError; end
end
