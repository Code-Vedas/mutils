# frozen_string_literal: true

require_relative 'mock_classes'
RSpec.describe Mutils do
  it 'has a version number' do
    expect(Mutils::VERSION).not_to be_nil
  end
end
