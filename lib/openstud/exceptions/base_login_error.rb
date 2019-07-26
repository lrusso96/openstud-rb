# frozen_string_literal: true

module Openstud
  module Exceptions
    # @abstract
    class BaseLoginError < BaseError
      err_type :invalid_password, :expired_password

      def initialize(msg = nil)
        super(msg)
      end
    end
  end
end
