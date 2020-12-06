require 'rails_helper'

RSpec.describe ::Services::TestService do
  subject{ described_class.new }

  it 'gives test output to test the project health' do
    expect(subject.sample_test).to eq 'foo'
  end
end