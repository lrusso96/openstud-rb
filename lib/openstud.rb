# frozen_string_literal: true

require 'bool'

# Main namespace for openstud-rb gem
#
# @since 0.1.0
module Openstud
  require 'openstud/version'
  require 'openstud/core/models/student'
  require 'openstud/phoenix'
  require 'openstud/error'
  require 'openstud/core/services/authenticator'
  require 'openstud/core/services/bio'
  require 'openstud/base'
end
