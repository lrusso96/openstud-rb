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
    def refresh_token!
      raise RefreshError, 'Student ID is not valid' unless valid_id?

      validate_refresh_token! JSON.parse execute_login
    rescue JSON::ParserError => e
      p e.message
    end

    # Authenticates the current [Base] user.
    # It tries at most @max_tries times to authenticate.
    #
    # @raise [InvalidCredentialsError] for invalid credentials
    # @raise [InvalidResponseError] for generic server error (e.g JSON error)
    def login!
      raise InvalidCredentialsError, 'Password is empty' unless valid_password?
      raise InvalidCredentialsError, 'Student is not valid' unless valid_id?

      retries ||= 0
      _login!
    rescue InvalidResponseError => e
      retry if (retries += 1) <= @max_tries
      raise e
    end

    private

    # Executes a login request, in order to update the current token
    #
    # @raise [InvalidResponseError]
    def execute_login
      params = { key: 'r4g4zz3tt1', matricola: @student_id,
                 stringaAutenticazione: @password }
      body = Phoenix.new(body: params).login
      raise InvalidResponseError 'Infostud answer is not valid' unless body

      if body.include? 'the page you are looking for is currently unavailable'
        raise InvalidResponseError.new('InfoStud is in maintenance')
                                  .maintenance!
      end

      body
    end

    # @param [Hash] response: the parsed response
    #
    # @raise [RefreshError] for invalid credentials
    # @raise [InvalidResponseError] for generic server error
    def validate_refresh_token!(response)
      @token = response['output']
      x = response['esito']['flagEsito']
      return if x.zero?
      raise RefreshError, 'Invalid credentials when refreshing token' if x == -4
      raise RefreshError.new('Password expired').expired_password! if x == -2
      raise RefreshError, 'Invalid credentials when refreshing token' if x == -1

      raise InvalidResponseError, 'Infostud is not working as intended'
    end

    #
    # @raise [InvalidCredentialsError] for invalid credentials
    # @raise [InvalidResponseError] for generic server error (e.g JSON error)
    def _login!
      body = execute_login
      res = JSON.parse body
      if body.include? 'Matricola errata'
        raise InvalidCredentialsError, 'Student ID is not valid'
      end

      validate_login! res
    rescue JSON::ParserError => e
      raise InvalidResponseError.new(e.message).json_error!
    end

    # @param [Hash] response: the parsed response
    #
    # @raise [UserNotEnabledError] for invalid student id
    # @raise [RefreshError] for invalid credentials
    # @raise [InvalidResponseError] for generic server error
    def validate_login!(response)
      @token = response['output']
      raise InvalidResponseError, 'Infostud answer is not valid' unless @token

      return if (x = response['esito']['flagEsito']).zero?
      if x == -4
      raise UserNotEnabledError, 'User is not enabled to use Infostud service'
      end
      raise RefreshError.new('Password expired').expired_password! if x == -2
      raise RefreshError, 'Password not valid' if x == -1

      raise InvalidResponseError, 'Infostud is not working as intended'
    end
  end
end
