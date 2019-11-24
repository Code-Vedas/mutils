class Room
  attr_accessor :name

  def initialize(name)
    self.name = name
  end
end
class House
  attr_accessor :name, :number, :rooms

  def initialize(name, number)
    self.name = name
    self.number = number
    self.rooms = [Room.new('room1'), Room.new('room2'), Room.new('room3')]
  end
end
class Country
  attr_accessor :name

  def initialize (name)
    self.name = name
  end
end
class User
  attr_accessor :first_name, :last_name, :houses, :country

  def initialize(first_name, last_name, houses)
    self.first_name = first_name
    self.last_name = last_name
    self.houses = houses
    self.country = Country.new('India')
  end
end
class CountrySerializer < Mutils::Serialization::BaseSerializer
  attributes :name
end
class HouseSerializer < Mutils::Serialization::BaseSerializer
  custom_methods :house_tag, :rooms_names

  def house_tag
    "#{scope.name}--#{scope.number}"
  end

  def rooms_names
    scope.rooms.map(&:name).join(',')
  end
end

class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :first_name, :last_name
  custom_methods :full_name
  has_many :houses, serializer: 'HouseSerializer', always_include: true
  belongs_to :country, serializer: CountrySerializer, always_include: true

  def full_name
    "#{scope.first_name} #{scope.last_name}"
  end

end