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
    s1 = (0...8).map { (65 + rand(26)).chr }.join
    s2 = (0...8).map { (65 + rand(26)).chr }.join
    s3 = (0...8).map { (65 + rand(26)).chr }.join
    self.rooms = [Room.new(s1), Room.new(s2), Room.new(s3)]
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

  def house_tag(scope)
    "#{scope.name}--#{scope.number}"
  end

  def rooms_names(scope)
    scope.rooms.map(&:name).join(',')
  end
end

class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :first_name, :last_name
  custom_methods :full_name
  has_many :houses, serializer: HouseSerializer, always_include: true
  belongs_to :country, serializer: CountrySerializer, always_include: true

  def full_name(scope)
    "#{scope.first_name} #{scope.last_name}"
  end

end