[![Maintainability](https://api.codeclimate.com/v1/badges/2c937dd6d25937ec41bd/maintainability)](https://codeclimate.com/github/niteshpurohit/mutils/maintainability)
![](https://ruby-gem-downloads-badge.herokuapp.com/mutils?type=total&color=brightgreen)
[![Gem Version](https://badge.fury.io/rb/mutils.svg)](https://badge.fury.io/rb/mutils)
[![Coverage Status](https://coveralls.io/repos/github/niteshpurohit/mutils/badge.svg?branch=feature/coverall)](https://coveralls.io/github/niteshpurohit/mutils?branch=feature/coverall)
[![Build Status](https://travis-ci.com/niteshpurohit/mutils.svg?branch=master)](https://travis-ci.com/niteshpurohit/mutils)
# Mutils
## Introduction
`mutils` is collection of useful modules for `ruby on rails` which is tested and benchmarked against high load.

These collection of modules are built by developer for developers :-)
## Installation

Add this line to your application's Gemfile:
```ruby
gem 'mutils'
```
And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install mutils

## Modules
| Sno 	|        Name       	| Status 	|
|:---:	|:-----------------:	|:------:	|
|  1  	| Serializer - JSON 	|  Done  	|
|  2  	|  Serializer - XML 	|  Done  	|

## Usage
### Serializer - JSON
JSON Serializer for Active Models 

#### Generate Serializer by command
```shell script
rails g mutils:serializer User id first_name last_name email

OUTPUT
Running via Spring preloader in process xxxxx
      create  app/serializers/user_serializer.rb
```
You will get serializer in app/serializers/user_serializer.rb
```ruby
# frozen_string_literal: true

# User Serializer
class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :id, :first_name, :last_name, :email
end
```

#### Decorations Available
1. Attributes
2. Custom Methods
3. Relations
3. name_tag

##### Attributes
Attributes are fields in the model itself. You can reference them by below example
```ruby
# frozen_string_literal: true

# User Serializer
class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :id, :first_name, :last_name, :email
end
```
##### Custom Methods
Custom methods used in Serializer can be useful for cases as below.
`scope` will be available to reference object in Serializer in below case its `user`

```ruby
# frozen_string_literal: true

# User Serializer
class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :id, :first_name, :last_name, :email
  custom_methods :full_name
  
  def full_name
    "#{scope.first_name} #{scope.last_name}"
  end
end
```
##### Relations
Relations such as `has_many`, `belongs_to`, `has_one` can be used as follows
1. Every relation must be provided with their own serializer
2. `always_include` option can be used to instruct `Serializer` to always include this relation
3. `always_include` by default is disabled, relations which are not `always_include` can be included while using the serializer. Refer to next section for this usage

```ruby
# frozen_string_literal: true

# User Serializer
class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :id, :first_name, :last_name, :email
  belongs_to :company, serializer: CompanySerializer, always_include: true
  has_many :comments, serializer: CommentSerializer
  has_one :account, serializer: AccountSerializer
  
  def full_name
    "#{scope.first_name} #{scope.last_name}"
  end
end
```
##### name_tag
name_tag is used to provide custom name to serializer output keys for json or tags for xml

**Options**
  - ``name_tag 'Person', true`` # Include Person or People in JSON serialization as root, true|false this only implies to root serializer
  - ``name_tag 'Person', false`` # not Include Person or People in JSON serialization as root, true|false this only implies to root serializer
  - ``name_tag 'Person'`` # same as ``name_tag 'Person', false``
  - without name_tag, actual class name of scope object inside serializer will be used 
```ruby
# frozen_string_literal: true

# User Serializer
class UserSerializer < Mutils::Serialization::BaseSerializer
  name_tag 'Person', true
  attributes :id, :first_name, :last_name, :email
  custom_methods :full_name
  
  def full_name
    "#{scope.first_name} #{scope.last_name}"
  end
end
```

## Usage: Use anywhere by

```ruby
user = User.first
options = {includes: [:comments,:account]}
UserSerializer.new(user,options).to_h
```
###or
```ruby
users = User.all
options = {includes: [:account]}
UserSerializer.new(users,options).to_json
```
###or in controllers
```ruby
users = User.all
options = {includes: [:account]}
users_serializer =UserSerializer.new(users,options)
render json: users_serializer
```

## Contributing

Bug Reports and PR's are welcomed in this repository kindly follow guidelines from `.github` directory.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Mutils project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/niteshpurohit/mutils/blob/master/CODE_OF_CONDUCT.md).
