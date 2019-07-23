# frozen_string_literal: true

RSpec.describe Openstud do
  it 'has a version number' do
    expect(Openstud::VERSION).to be '0.0.1'
  end

  it 'succesfully logins' do
    base = Openstud::Base.new
    base.student_id = ENV['STUDENT_ID']
    base.password = ENV['STUDENT_PWD']
    base.login
    expect(base.token.empty?).to be false
  end

  it 'raises RefreshException for invalid credentials' do
    base = Openstud::Base.new student_id: 1234567, password: 'password'
    expect { base.login }.to raise_error(Openstud::Exceptions::RefreshError)
  end
end
