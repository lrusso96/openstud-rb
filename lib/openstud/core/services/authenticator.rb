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
    # @raise [ResponseError] for generic server error
    def refresh_token!
      raise RefreshError, 'Student ID is not valid' unless valid_id?

      validate_refresh_token! JSON.parse execute_login
    rescue JSON::ParserError => e
      p e.message
    end

    # Authenticates the current [Base] user.
    # It tries at most @max_tries times to authenticate.
    #
    # @raise [CredentialsError] for invalid credentials
    # @raise [ResponseError] for generic server error (e.g JSON error)
    def login!
      validate_credentials!
      begin
        retries ||= 0
        try_login!
      rescue ResponseError => e
        retry if (retries += 1) <= @max_tries
        raise e
      end
    end

    private

    # @raise [CredentialsError] for invalid credentials
    def validate_credentials!
      raise CredentialsError, 'Password is empty' unless valid_password?
      raise CredentialsError, 'Student is not valid' unless valid_id?
    end

    # Executes a login request, in order to update the current token
    #
    # @raise [ResponseError]
    def execute_login
      params = { key: 'r4g4zz3tt1', matricola: @student_id,
                 stringaAutenticazione: @password }
      body = Phoenix.new(body: params).login
      raise ResponseError 'Infostud answer is not valid' unless body

      if body.include? 'the page you are looking for is currently unavailable'
        raise ResponseError.new('InfoStud is in maintenance')
                           .maintenance!
      end
      body
    end

    # @param [Hash] response: the parsed response
    #
    # @raise [RefreshError] for invalid credentials
    # @raise [ResponseError] for generic server error
    def validate_refresh_token!(response)
      @token = response['output']
      x = response['esito']['flagEsito']
      return if x.zero?
      raise RefreshError, 'Invalid credentials when refreshing token' if x == -4
      raise RefreshError.new('Password expired').expired_password! if x == -2
      raise RefreshError, 'Invalid credentials when refreshing token' if x == -1

      raise ResponseError, 'Infostud is not working as intended'
    end

    # @raise [CredentialsError] for invalid credentials
    # @raise [ResponseError] for generic server error (e.g JSON error)
    def try_login!
      validate_try_login! execute_login
    rescue JSON::ParserError => e
      raise ResponseError.new(e.message).json_error!
    end

    #
    # @param [String] body
    def validate_try_login!(body)
      validate_login_body! body
      res = JSON.parse body
      validate_login_response! res
      extract_token! res
    end

    #
    # @param [String] body
    # @raise [CredentialsError] if student ID is not valid
    def validate_login_body!(body)
      err = 'Matricola errata'
      msg = 'Student ID is not valid'
      raise CredentialsError, msg if body.include? err
    end

    #
    # @param [Hash] response: the parsed response
    #
    # @raise [UserNotEnabledError] for invalid student id
    # @raise [RefreshError] for invalid credentials
    # @raise [ResponseError] for generic server error
    def validate_login_response!(response)
      x = response['esito']['flagEsito']
      return if x.zero?
      if x == -4
        raise UserNotEnabledError, 'User is not enabled to use Infostud service'
      end
      raise RefreshError.new('Password expired').expired_password! if x == -2
      raise RefreshError, 'Password not valid' if x == -1

      raise ResponseError, 'Infostud is not working as intended'
    end

    #
    # @param [String] response
    def extract_token!(response)
      @token = response['output']
      raise ResponseError, 'Infostud answer is not valid' unless @token
    end
  end
end
