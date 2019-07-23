# frozen_string_literal: true

module Openstud
  class Base
    include Authenticator

    attr_accessor :studentID
    attr_accessor :password
    attr_accessor :token
  end
end
