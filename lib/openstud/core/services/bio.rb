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
      (0..).each do |count|
        login! if count.positive?
        return _info_student!
      rescue InvalidResponseError => e
        raise e if count == @max_tries
      rescue RefreshError => e
        raise InvalidCredentialsError, e.message
      end
    end

    private

    def _info_student!
      res = Phoenix.new.info_student(@student_id, @token)
      validate_info_student! res
      # TODO: parse student and return
      res
    end

    # @param [Hash] response
    def validate_info_student!(response)
      unless response.key? 'ritorno'
        raise InvalidResponseError, 'Infostud response is not valid.'\
                                    'I guess the token is no longer valid'
      end
    end
  end
end
