# frozen_string_literal: true
class UserConditional
  attr_accessor :name
  attr_accessor :users

  def initialize(name, users)
    self.name = name
    self.users = users
  end
end

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

  def initialize(name)
    self.name = name
  end
end

class Car
  attr_accessor :number

  def initialize(number)
    self.number = number
  end
end

class Bike
  attr_accessor :number

  def initialize(number)
    self.number = number
  end
end

class User
  attr_accessor :first_name, :last_name, :houses, :country, :cars, :bikes

  def initialize(first_name, last_name, houses)
    self.first_name = first_name
    self.last_name = last_name
    self.houses = houses
    self.country = Country.new('Country')
  end
end

class UserConditionalSerializer < Mutils::Serialization::BaseSerializer
  attribute :name, if: proc { |scope| scope.name == 'mutils' }
  has_many :users, if: proc { |scope| scope.name == 'mutils_with_array' }, serializer: UserConditionalSerializer
end

class CountrySerializer < Mutils::Serialization::BaseSerializer
  attributes :name
end

class CarSerializer < Mutils::Serialization::BaseSerializer
  attributes :number
end

class BikeSerializer < Mutils::Serialization::BaseSerializer
  attributes :number
end

class HouseSerializer < Mutils::Serialization::BaseSerializer
  custom_methods :house_tag
  custom_method :rooms_names, always_include: true
  custom_method :house_tag_underscore
  custom_method :house_tag_plus, always_include: false

  def house_tag
    "#{scope.name}--#{scope.number}"
  end

  def house_tag_underscore
    "#{scope.name}--#{scope.number}"
  end

  def house_tag_plus
    "#{scope.name}--#{scope.number}"
  end

  def rooms_names
    scope.rooms.map(&:name).join(',')
  end
end

class HouseSerializerNameTag < Mutils::Serialization::BaseSerializer
  name_tag 'house', true
  custom_methods :house_tag
  custom_method :rooms_names, always_include: true
  custom_method :house_tag_underscore
  custom_method :house_tag_plus, always_include: false

  def house_tag
    "#{scope.name}--#{scope.number}"
  end

  def house_tag_underscore
    "#{scope.name}--#{scope.number}"
  end

  def house_tag_plus
    "#{scope.name}--#{scope.number}"
  end

  def rooms_names
    scope.rooms.map(&:name).join(',')
  end
end
class HouseSerializerNameTag2 < Mutils::Serialization::BaseSerializer
  name_tag nil, true
  custom_methods :house_tag
  custom_method :rooms_names, always_include: true
  custom_method :house_tag_underscore
  custom_method :house_tag_plus, always_include: false

  def house_tag
    "#{scope.name}--#{scope.number}"
  end

  def house_tag_underscore
    "#{scope.name}--#{scope.number}"
  end

  def house_tag_plus
    "#{scope.name}--#{scope.number}"
  end

  def rooms_names
    scope.rooms.map(&:name).join(',')
  end
end

class UserBlocksSerializer < Mutils::Serialization::BaseSerializer
  attributes :first_name, :last_name
  attribute :full_name do |user|
    "#{user.first_name} #{user.last_name}"
  end
end

class UserBlocksParamsSerializer < Mutils::Serialization::BaseSerializer
  attributes :first_name, :last_name
  attribute :full_name do |user, params|
    "#{user.first_name} #{user.last_name} #{params}"
  end
end
class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :first_name, :last_name
  custom_methods :full_name
  has_many :houses, serializer: 'HouseSerializer', always_include: true
  belongs_to :country, serializer: CountrySerializer, always_include: true
  has_many :cars, serializer: CarSerializer, label: 'car'
  has_many :bikes, serializer: BikeSerializer, always_include: false

  def full_name
    "#{scope.first_name} #{scope.last_name}"
  end
end
