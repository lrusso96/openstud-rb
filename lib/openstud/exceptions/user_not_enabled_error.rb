# frozen_string_literal: true

module Openstud
  module Exceptions
    # class for user not enabled
    class UserNotEnabledError < BaseError
      def initialize(msg = nil)
        super(msg)
      end
    end
  end
end
