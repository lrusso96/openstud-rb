# frozen_string_literal: true

RSpec.describe Openstud do
  it 'successfully logins and get infos' do
    base = Openstud::Base.new
    base.student_id = ENV['STUDENT_ID']
    base.password = ENV['STUDENT_PWD']
    base.login!
    expect(base.token.empty?).to be false
    base.info_student!
  end

  it 'raises RefreshException for invalid credentials' do
    base = Openstud::Base.new student_id: '1234567', password: 'password'
    expect { base.login! }.to raise_error Openstud::Exceptions::RefreshError
  end

  it 'raises InvalidCredentials' do
    base = Openstud::Base.new student_id: '1234567', password: 'password'
    expect { base.info_student! }
      .to raise_error Openstud::Exceptions::InvalidCredentialsError
  end
end