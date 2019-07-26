# frozen_string_literal: true

module Openstud
  # Model for student
  class Student
    attr_accessor :fiscal_code, :first_name, :last_name, :gender, :email,
                  :birth_date, :birth_city, :birth_place, :nation, :citizenship
    attr_accessor :student_id, :first_enrollment, :last_enrollment,
                  :course_year, :student_status, :academic_year, :cfu,
                  :academic_year_course, :code_course, :type_student, :erasmus,
                  :department_name, :course_name
  end
end
