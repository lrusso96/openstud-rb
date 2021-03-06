# frozen_string_literal: true

module Openstud
  module Exceptions
    # class for invalid refresh
    class RefreshError < BaseLoginError
      def initialize(msg = nil)
        super(msg)
      end
    end
  end
end
