# frozen_string_literal: true

module Openstud
  module Exceptions
    class InvalidResponseError < BaseResponseError
      def initialize(msg)
        super(msg)
      end
    end
  end
end