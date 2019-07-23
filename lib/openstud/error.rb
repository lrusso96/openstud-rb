# frozen_string_literal: true

module Openstud
  module Exceptions
    class BaseError < StandardError
      attr_accessor :types

      def initialize(msg, types: [])
        super(msg)
        @types = types
        i = 0
        types.each do |s|
          s = s.to_s
          self.class.send(:define_method,s + '!') do
            @types[i] = true
            self
          end
          self.class.send(:define_method,s + '?') { @types[i] }
          i += 1
        end
      end
    end

    require_relative './exceptions/base_login_error.rb'
    require_relative './exceptions/refresh_error.rb'

    require_relative './exceptions/base_response_error.rb'
    require_relative './exceptions/invalid_response_error.rb'
  end
end
