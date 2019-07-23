# frozen_string_literal: true

module Openstud
  module Exceptions
    class RefreshError < BaseLoginError
      def initialize(msg)
        super(msg)
      end
    end
  end
end