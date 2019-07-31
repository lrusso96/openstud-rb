# frozen_string_literal: true

RSpec.describe 'Response errors' do
  it 'raises InvalidResponse' do
    r = Openstud::Exceptions::ResponseError.new('Invalid')
    expect(r.json_error?).to be false
    r.json_error!
    expect(r.json_error?).to be true
    expect(r.maintenance?).to be false
    r.maintenance!
    expect(r.maintenance?).to be true
    expect(r.rate_limit?).to be false
    r.rate_limit!
    expect(r.rate_limit?).to be true
    expect(r.html_error?).to be false
    r.html_error!
    expect(r.html_error?).to be true
  end
end
