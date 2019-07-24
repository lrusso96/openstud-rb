# frozen_string_literal: true

require 'json'

module Openstud
  # Namespace for methods that handle authentication, e.g. login
  #
  # @since 0.1.0
  module Authenticator
    include Exceptions

    # Authenticates the current [Base] user, updating its token
    #
    # @raise [RefreshError] for invalid credentials
    # @raise [InvalidResponseError] for generic server error
    def login!
      params = { key: 'r4g4zz3tt1', matricola: @student_id,
                 stringaAutenticazione: @password }
      res = Phoenix.new(body: params).login
      validate_login! res
    end

    private

    # @param [Hash] response: the parsed response
    #
    # @raise [RefreshError] for invalid credentials
    # @raise [InvalidResponseError] for generic server error
    def validate_login!(response)
      @token = response['output']
      x = response['esito']['flagEsito']
      return if x.zero?
      raise RefreshError, 'Invalid credentials when refreshing token' if x == -4
      raise RefreshError.new('Password expired').expired_password! if x == -2
      raise RefreshError, 'Invalid credentials when refreshing token' if x == -1

      raise InvalidResponseError, 'Infostud is not working as intended'
    end
  end
end
