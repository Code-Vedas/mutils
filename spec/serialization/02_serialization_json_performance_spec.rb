# frozen_string_literal: true

require_relative '../mock_classes'
require_relative './expect_output'
require 'rspec/json_expectations'

RSpec.describe 'Mutils::Serialization::JSON::Performance', performance: true do
  before(:all) { GC.disable }
  after(:all) { GC.enable }
  it('Serialize 250 records in 10ms') do
    houses = [House.new('ha', 1)]
    user = User.new('FirstName', 'LastName', houses)
    user.cars = [Car.new('123'), Car.new('456')]
    user.bikes = [Bike.new('abc'), Bike.new('xyz')]
    users = []
    250.times do
      users << user
    end
    expect { UserSerializer.new(users, includes: %i[bikes cars]).to_h }.to perform_under(10).ms
  end

  it('Serialize 1000 records in 40ms') do
    houses = [House.new('ha', 1)]
    user = User.new('FirstName', 'LastName', houses)
    user.cars = [Car.new('123'), Car.new('456')]
    user.bikes = [Bike.new('abc'), Bike.new('xyz')]
    users = []
    1000.times do
      users << user
    end
    expect { UserSerializer.new(users, includes: %i[bikes cars]).to_h }.to perform_under(40).ms
  end

  it('Serialize 10000 records in 240ms') do
    houses = [House.new('ha', 1)]
    user = User.new('FirstName', 'LastName', houses)
    user.cars = [Car.new('123'), Car.new('456')]
    user.bikes = [Bike.new('abc'), Bike.new('xyz')]
    users = []
    10_000.times do
      users << user
    end
    expect { UserSerializer.new(users, includes: %i[bikes cars]).to_h }.to perform_under(240).ms
  end
end