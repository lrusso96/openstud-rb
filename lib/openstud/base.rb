# frozen_string_literal: true

module Openstud
  class Base
    include Authenticator

    attr_accessor :student_id
    attr_accessor :password
    attr_accessor :token

    def initialize(student_id: '', password: '')
      @student_id = student_id
      @password = password
    end
  end
end
