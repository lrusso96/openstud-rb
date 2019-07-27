# frozen_string_literal: true

require 'httparty'

module Openstud
  ENDPOINT_API = 'https://www.studenti.uniroma1.it/phoenixws'

  # Http utils class that defines Infostud paths
  #
  # @since 0.1.0
  class Phoenix
    include HTTParty

    attr_reader :headers
    attr_reader :options

    def initialize(body: {})
      @headers = { 'Content-EventType' => 'application/x-www-form-urlencoded',
                   Accept: 'application/json' }
      @options = { headers: @headers, body: body }
    end

    def login
      self.class.post("#{ENDPOINT_API}/autenticazione", @options).body
    end

    # TODO: return the response, not the parsed body
    def info_student(id, token)
      easy self.class.get("#{ENDPOINT_API}/studente/#{id}?ingresso=#{token}",
                          @options)
    end

    private

    # TODO: remove this to catch exceptions in each module!
    def easy(res)
      JSON.parse res.body
    end
  end
end
