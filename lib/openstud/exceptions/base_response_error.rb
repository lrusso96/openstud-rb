# frozen_string_literal: true

module Openstud
  module Exceptions
    # @abstract
    class BaseResponseError < BaseError
      err_type :json_error, :maintenance, :rate_limit, :html_error,
               :generic

      def initialize(msg = nil)
        super(msg)
      end
    end
  end
end
