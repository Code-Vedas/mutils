# frozen_string_literal: true

require_relative './mock_classes'
RSpec.describe Mutils do
  it 'has a version number' do
    expect(Mutils::VERSION).not_to be nil
  end
end
