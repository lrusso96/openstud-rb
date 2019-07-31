# frozen_string_literal: true

module Openstud
  module Exceptions
    # class for invalid response
    class ResponseError < BaseResponseError
      def initialize(msg = nil)
        super(msg)
      end
    end
  end
end
