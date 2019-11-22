require_relative './mock_classes'
RSpec.describe Mutils do
  it 'has a version number' do
    expect(Mutils::VERSION).not_to be nil
  end
  it 'it should serialize simple object' do
    houses1 = [House.new('ha', 1), House.new('hb', 2)]
    serializer = UserSerializer.new(User.new('FirstName', 'LastName', houses1))
    puts serializer.to_h.inspect
  end
  it 'it should serialize simple array of objects' do

    houses1 = [House.new('ha', 1), House.new('hb', 2)]
    houses2 = [House.new('hp', 1), House.new('hq', 2)]

    serializer = UserSerializer.new([User.new('FirstName1', 'LastName1', houses1), User.new('FirstName2', 'LastName2', houses2)])
    puts serializer.to_h.inspect
  end
end
