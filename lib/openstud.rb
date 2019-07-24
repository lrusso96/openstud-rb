# frozen_string_literal: true

require 'openstud/version'

module Openstud
  require_relative './openstud/phoenix.rb'
  require_relative './openstud/error.rb'
  require_relative './openstud/core/services/authenticator.rb'
  require_relative './openstud/core/services/bio.rb'
  require_relative './openstud/base.rb'
end
