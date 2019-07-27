# frozen_string_literal: true

require 'json'
require 'httparty'

module Openstud
  # Namespace for methods that handle bio infos
  #
  # @since 0.1.0
  module Bio
    include Exceptions

    def info_student!
      retries ||= 0
      refresh_token! if retries.positive?
      _info_student!
    rescue InvalidResponseError => e
      retry if (retries += 1) <= @max_tries
      raise e
    rescue RefreshError => e
      raise InvalidCredentialsError, e.message
    end

    private

    def _info_student!
      res = Phoenix.new.info_student(@student_id, @token)
      validate_info_student! res
      # TODO: parse student and return
      res['ritorno']['nome']
    end

    # @param [Hash] response
    def validate_info_student!(response)
      fine = response.key?('ritorno')
      msg = 'I guess the token is no longer valid'
      raise InvalidResponseError, msg unless fine
    end
  end
end
