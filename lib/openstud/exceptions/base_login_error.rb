# frozen_string_literal: true

module Openstud
  module Exceptions
    # @abstract
    class BaseLoginError < BaseError
      def initialize(msg)
        super(msg, types: %i[invalid_password expired_password])
      end
    end
  end
end
