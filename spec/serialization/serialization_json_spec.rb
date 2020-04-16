# frozen_string_literal: true

require_relative '../mock_classes'
require_relative './expect_output'
require 'rspec/json_expectations'

RSpec.describe 'Mutils::Serialization::JSON' do
  it 'it should serialize user to JSON' do
    houses = nil
    serializer = UserSerializer.new(User.new('FirstName', 'LastName', houses))
    expect(serializer.to_json).to include_json(USER_JSON)
    expect(serializer.to_h[:houses].length).to eq(0)
  end
  it 'it should serialize user with house JSON' do
    houses = [House.new('ha', 1)]
    serializer = UserSerializer.new(User.new('FirstName', 'LastName', houses))
    expect(serializer.to_json).to include_json(USER_WITH_HOUSES_JSON)
    result = serializer.to_h
    expect(result[:houses].length).to eq(1)
  end
  it 'it should serialize method with not always_included' do
    house = House.new('ha', 1)
    serializer = HouseSerializer.new(house, includes: [:house_tag_underscore])
    expect(serializer.to_h[:house_tag_underscore]).to eq('ha--1')
    serializer = HouseSerializer.new(house, includes: [:house_tag_plus])
    expect(serializer.to_h[:house_tag_plus]).to eq('ha--1')
  end
  it 'it should serialize users JSON' do
    houses1 = [House.new('ha', 1), House.new('hb', 2)]
    houses2 = [House.new('hp', 1), House.new('hq', 2), House.new('hr', 3)]

    serializer = UserSerializer.new([User.new('FirstName1', 'LastName1', houses1), User.new('FirstName2', 'LastName2', houses2)])
    expect(serializer.to_json).to include_json(USERS_JSON)
    result = serializer.to_h
    expect(result[0][:houses].length).to eq(2)
    expect(result[1][:houses].length).to eq(3)
  end
  it 'it should serialize 4000 houses for user JSON' do
    index = 1
    houses = []
    4000.times do
      houses << House.new("a-#{index}", index)
    end
    serializer = UserSerializer.new(User.new('FirstName1', 'LastName1', houses))
    serializer.to_json
    expect(serializer.to_h[:houses].length).to eq(4000)
  end
  it 'it should serialize 40_000 houses for user JSON' do
    index = 1
    houses = []
    40_000.times do
      houses << House.new("a-#{index}", index)
    end
    serializer = UserSerializer.new(User.new('FirstName1', 'LastName1', houses))
    serializer.to_json
    expect(serializer.to_h[:houses].length).to eq(40_000)
  end
  it 'it should not have car and bike' do
    houses = [House.new('ha', 1)]
    user = User.new('FirstName', 'LastName', houses)
    user.cars = [Car.new('123'), Car.new('456')]
    user.bikes = [Bike.new('abc'), Bike.new('xyz')]
    serializer = UserSerializer.new(user)
    expect(serializer.to_json).to include_json(USER_WITH_HOUSES_JSON)
    result = serializer.to_h
    expect(result[:houses].length).to eq(1)
    expect(result[:cars]).to eq(nil)
    expect(result[:bikes]).to eq(nil)
  end

  it 'it should have cars not bikes' do
    houses = [House.new('ha', 1)]
    user = User.new('FirstName', 'LastName', houses)
    user.cars = [Car.new('123'), Car.new('456')]
    user.bikes = [Bike.new('abc'), Bike.new('xyz')]
    serializer = UserSerializer.new(user, includes: [:cars])
    result = serializer.to_h
    expect(result[:houses].length).to eq(1)
    expect(result[:cars].length).to eq(2)
    expect(result[:bikes]).to eq(nil)
  end

  it 'it should have bikes not cars' do
    houses = [House.new('ha', 1)]
    user = User.new('FirstName', 'LastName', houses)
    user.cars = [Car.new('123'), Car.new('456')]
    user.bikes = [Bike.new('abc'), Bike.new('xyz')]
    serializer = UserSerializer.new(user, includes: [:bikes])
    result = serializer.to_h
    expect(result[:houses].length).to eq(1)
    expect(result[:bikes].length).to eq(2)
    expect(result[:cars]).to eq(nil)
  end
  it 'it should have bikes and cars' do
    houses = [House.new('ha', 1)]
    user = User.new('FirstName', 'LastName', houses)
    user.cars = [Car.new('123'), Car.new('456')]
    user.bikes = [Bike.new('abc'), Bike.new('xyz')]
    serializer = UserSerializer.new(user, includes: %i[bikes cars])
    result = serializer.to_h
    expect(result[:houses].length).to eq(1)
    expect(result[:bikes].length).to eq(2)
    expect(result[:cars].length).to eq(2)
  end
  it 'it should return user name with mutils: testing conditional attributes' do
    user = UserConditional.new('mutils', nil)
    serializer = UserConditionalSerializer.new(user)
    result = serializer.to_h
    expect(result[:name]).to eq('mutils')
    expect(result[:users]).to eq(nil)
  end
  it 'it should return user name with mutils: testing conditional relationship' do
    user1 = UserConditional.new('mutils', nil)
    user2 = UserConditional.new('mutils', nil)
    user = UserConditional.new('mutils_with_array', [user1, user2])
    serializer = UserConditionalSerializer.new(user)
    result = serializer.to_h
    expect(result[:name]).to eq(nil)
    expect(result[:users].length).to eq(2)
    expect(result[:users][0][:name]).to eq('mutils')
    expect(result[:users][1][:name]).to eq('mutils')
  end
  it 'it should have full name: block style attributes' do
    user = User.new('FirstName', 'LastName', nil)
    serializer = UserBlocksSerializer.new(user)
    result = serializer.to_h
    expect(result[:first_name]).to eq('FirstName')
    expect(result[:last_name]).to eq('LastName')
    expect(result[:full_name]).to eq('FirstName LastName')
  end
  it 'it should have full name: block style attributes with params' do
    user = User.new('FirstName', 'LastName', nil)
    serializer = UserBlocksParamsSerializer.new(user, { params: 'II' })
    result = serializer.to_h
    expect(result[:first_name]).to eq('FirstName')
    expect(result[:last_name]).to eq('LastName')
    expect(result[:full_name]).to eq('FirstName LastName II')
  end
  it 'it should serialize house JSON: NameTag: Array' do
    houses = [House.new('ha', 1), House.new('ha', 2)]
    serializer = HouseSerializerNameTag.new(houses)
    result1 = JSON.parse(serializer.to_json)
    result = serializer.to_h
    expect(result1["houses"].length).to eq(2)
    expect(result.length).to eq(2)
  end
  it 'it should serialize house JSON: NameTag: Single' do
    houses = House.new('ha', 1)
    serializer = HouseSerializerNameTag2.new(houses)
    result1 = JSON.parse(serializer.to_json)
    result = serializer.to_h
    expect(result1['house']['house_tag']).to eq("ha--1")
    expect(result[:house_tag]).to eq("ha--1")
  end
  it 'Throws Exception when serializer for relation is not given' do
    begin
      class UserSerializerFailing < Mutils::Serialization::BaseSerializer
        has_many :bikes, serializer: nil, always_include: false
      end
    rescue RuntimeError
      expect(true).to be(true)
    end
  end
  it 'Throws Exception when serializer for relation is not valid' do
    begin
      class UserSerializerFailing < Mutils::Serialization::BaseSerializer
        has_many :bikes, serializer: 'MyClass', always_include: false
      end
    rescue RuntimeError
      expect(true).to be(true)
    end
  end
end
