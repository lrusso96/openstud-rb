# frozen_string_literal: true

require 'json'

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
    rescue ResponseError => e
      retry if (retries += 1) <= @max_tries
      raise e
    rescue RefreshError => e
      raise CredentialsError, e.message
    end

    private

    # @return [Student]
    def _info_student!
      # TODO: parse here JSON to catch errors
      res = Phoenix.new.info_student(@student_id, @token)
      validate_info_student! res
      extract_student res
    end

    # @param [Hash] response
    def validate_info_student!(response)
      fine = response.key?('ritorno')
      msg = 'I guess the token is no longer valid'
      raise ResponseError, msg unless fine
    end

    # @param [Hash] response
    # @return [Student]
    def extract_student(response)
      res = response['ritorno']
      st = Student.new
      st.student_id = @student_id
      # TODO: add proper parser for int fields (e.g. cfu)
      basic_fields.each do |f, k|
        st.send(f.to_s + '=', res[k])
      end
      st
    end

    def basic_fields
      { fiscal_code: 'codiceFiscale', last_name: 'cognome',
        first_name: 'nome', birth_city: 'comuneDiNasciata',
        birth_place: 'luogoDiNascita', course_year: 'annoCorso',
        first_enrollment: 'primaIscr', last_enrollment: 'ultIscr',
        department_name: 'facolta', course_name: 'nomeCorso',
        academic_year: 'annoAccaAtt', code_course: 'codCorso',
        type_student: 'tipoStudente', student_status: 'tipoIscrizione',
        erasmus: 'isErasmus', nation: 'nazioneNascita', gender: 'sesso',
        cfu: 'creditiTotali', email: 'indiMailIstituzionale',
        academic_year_course: 'annoAccaCors', citizenship: 'cittadinanza' }
    end
  end
end
