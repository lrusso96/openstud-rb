# frozen_string_literal: true

module Openstud
  # Namespace for Openstud errors
  #
  # @since 0.1.0
  module Exceptions
    # @abstract class that defines common methods to handle custom error types
    class BaseError < StandardError
      attr_accessor :types

      def initialize(msg, types: [])
        super(msg)
        @types = types
        types.each_with_index do |val, i|
          s = val.to_s
          self.class.send(:define_method, s + '!') do
            @types[i] = true
            self
          end
          self.class.send(:define_method, s + '?') { @types[i] }
        end
      end
    end

    require_relative './exceptions/base_login_error.rb'
    require_relative './exceptions/refresh_error.rb'
    require_relative './exceptions/invalid_credentials_error.rb'

    require_relative './exceptions/base_response_error.rb'
    require_relative './exceptions/invalid_response_error.rb'
  end
end
