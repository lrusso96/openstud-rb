# frozen_string_literal: true

RSpec.describe 'Authenticator' do
  context 'for valid credentials' do
    it 'get infos' do
      base = Openstud::Base.new
      base.student_id = ENV['STUDENT_ID']
      base.password = ENV['STUDENT_PWD']
      expect(base.info_student!).to eq 'LUIGI'
    end
  end

  context 'when credentials are invalid' do
    it 'fails to login' do
      base = Openstud::Base.new student_id: '1234567', password: 'password'
      expect { base.login! }.to raise_error Openstud::Exceptions::RefreshError
    end

    it 'fails to geti infos' do
      base = Openstud::Base.new student_id: '1234567', password: 'password'
      expect { base.info_student! }
        .to raise_error Openstud::Exceptions::InvalidCredentialsError
    end
  end
end