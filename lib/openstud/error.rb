# frozen_string_literal: true

# @abstract
class Class
  alias err_type bool_accessor
end

module Openstud
  # Namespace for Openstud errors
  #
  # @since 0.1.0
  module Exceptions
    # @abstract class that defines common methods to handle custom error types
    class BaseError < StandardError
      def initialize(msg = nil)
        super(msg)
      end
    end

    require_relative './exceptions/base_login_error.rb'
    require_relative './exceptions/refresh_error.rb'
    require_relative './exceptions/credentials_error.rb'

    require_relative './exceptions/base_response_error.rb'
    require_relative './exceptions/response_error.rb'
  end
end
