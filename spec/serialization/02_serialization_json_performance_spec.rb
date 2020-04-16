# frozen_string_literal: true

require_relative '../mock_classes'
require_relative './expect_output'
require 'rspec/json_expectations'

RSpec.describe 'Mutils::Serialization::JSON::Performance', performance: true do
  before(:all) { GC.disable }
  after(:all) { GC.enable }
  it('Serialize 250 records in 2ms') do
    houses = [House.new('ha', 1)]
    user = User.new('FirstName', 'LastName', houses)
    user.cars = [Car.new('123'), Car.new('456')]
    user.bikes = [Bike.new('abc'), Bike.new('xyz')]
    users = []
    250.times do
      users << user
    end
    expect { UserSerializer.new(users).to_h }.to perform_under(3).ms
  end
end