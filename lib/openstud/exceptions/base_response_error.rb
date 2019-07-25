# frozen_string_literal: true

module Openstud
  module Exceptions
    # @abstract
    class BaseResponseError < BaseError
      def initialize(msg)
        super(msg,
              types: %i[json_error maintenance rate_limit html_error generic])
      end
    end
  end
end
