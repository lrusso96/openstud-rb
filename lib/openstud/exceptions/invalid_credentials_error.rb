# frozen_string_literal: true

module Openstud
  module Exceptions
    # class for invalid refresh
    class InvalidCredentialsError < BaseLoginError
      def initialize(msg)
        super(msg)
      end
    end
  end
end