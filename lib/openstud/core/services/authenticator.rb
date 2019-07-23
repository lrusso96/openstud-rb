# frozen_string_literal: true

require 'json'
require 'httparty'

module Openstud
  module Authenticator
    include Exceptions

    def login
      params = { key: 'r4g4zz3tt1', matricola: @studentID,
                 stringaAutenticazione: @password }
      headers = { 'Content-EventType' => 'application/x-www-form-urlencoded',
                  Accept: 'application/json' }
      opt = { body: params, headers: headers }
      res = JSON.parse HTTParty.post("#{ENDPOINT_API}/autenticazione", opt).body
      @token = res['output']
      handle_login_errors res
    end

    private

    def handle_login_errors(res)
      x = res['esito']['flagEsito']
      return if x.zero?
      raise RefreshError, 'Invalid credentials when refreshing token' if x == -4
      raise RefreshError.new('Password expired').expired_password! if x == -2
      raise RefreshError, 'Invalid credentials when refreshing token' if x == -1

      raise StandardError, 'Infostud is not working as intended'
    end
  end
end
