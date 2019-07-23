# frozen_string_literal: true

RSpec.describe Openstud do
  it 'has a version number' do
    expect(Openstud::VERSION).not_to be nil
  end

  it 'does something' do
    base = Openstud::Base.new
    base.studentID = '1234567'
    base.password = 'password'
    # base.login
    # expect(base.token.size).to be > 0
  end
end
