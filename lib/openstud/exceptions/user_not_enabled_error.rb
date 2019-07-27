# frozen_string_literal: true

module Openstud
  module Exceptions
    class UserNotEnabledError < BaseError
      def initialize(msg = nil)
        super(msg)
      end
    end
  end
end
