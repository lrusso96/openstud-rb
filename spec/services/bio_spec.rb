# frozen_string_literal: true

RSpec.describe 'Bio' do
  context 'for valid credentials' do
    it 'get infos' do
      base = Openstud::Base.new
      base.student_id = ENV['STUDENT_ID']
      base.password = ENV['STUDENT_PWD']
      st = base.info_student!
      expect(st.student_id).to eq base.student_id
      expect(st.citizenship.empty?).to be false
    end
  end

  context 'when credentials are invalid' do
    it 'fails to get infos' do
      base = Openstud::Base.new student_id: '1234567', password: 'password'
      expect { base.info_student! }
        .to raise_error Openstud::Exceptions::CredentialsError
    end
  end
end
