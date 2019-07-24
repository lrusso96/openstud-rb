# frozen_string_literal: true

module Openstud
  class Base
    include Authenticator
    include Bio

    attr_accessor :student_id
    attr_accessor :password
    attr_accessor :token
    attr_reader :max_tries

    def initialize(student_id: '', password: '')
      @student_id = student_id
      @password = password
      @max_tries = 3
    end
  end
end
