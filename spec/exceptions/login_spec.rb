RSpec.describe 'Login errors' do
  it 'raises RefreshError' do
    r = Openstud::Exceptions::RefreshError.new 'Password expired'
    expect(r.expired_password?).to be false
    r.expired_password!
    expect(r.expired_password?).to be true
    expect(r.invalid_password?).to be false
    r.invalid_password!
    expect(r.invalid_password?).to be true
  end

  it 'raises CredentialsError' do
    r = Openstud::Exceptions::CredentialsError.new 'Invalid'
    expect(r.expired_password?).to be false
    r.expired_password!
    expect(r.expired_password?).to be true
    expect(r.invalid_password?).to be false
    r.invalid_password!
    expect(r.invalid_password?).to be true
  end
end
