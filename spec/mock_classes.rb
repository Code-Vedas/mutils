class House
  attr_accessor :name, :number

  def initialize(name, number)
    self.name = name
    self.number = number
  end
end
class User
  attr_accessor :first_name, :last_name, :houses

  def initialize(first_name, last_name, houses)
    self.first_name = first_name
    self.last_name = last_name
    self.houses = houses
  end
end

class HouseSerializer < Mutils::Serialization::BaseSerializer
  custom_methods :house_tag

  def house_tag(scope)
    "#{scope.name}--#{scope.number}"
  end
end

class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :first_name, :last_name
  custom_methods :full_name
  has_many :houses, serializer: HouseSerializer, always_include: true

  def full_name(scope)
    "#{scope.first_name} #{scope.last_name}"
  end

end