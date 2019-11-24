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
  it 'it should serialize users JSON' do

    houses1 = [House.new('ha', 1), House.new('hb', 2)]
    houses2 = [House.new('hp', 1), House.new('hq', 2),House.new('hr', 3)]

    serializer = UserSerializer.new([User.new('FirstName1', 'LastName1', houses1), User.new('FirstName2', 'LastName2', houses2)])
    expect(serializer.to_json).to include_json(USERS_JSON)
    puts serializer.to_xml
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
    expect(serializer.to_h[:houses].length).to eq(40000)
  end
end
