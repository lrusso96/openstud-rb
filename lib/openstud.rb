# frozen_string_literal: true

require 'openstud/version'

module Openstud
  ENDPOINT_API = 'https://www.studenti.uniroma1.it/phoenixws'
  require_relative './openstud/core/services/authenticator.rb'
  require_relative './openstud/base.rb'
end
