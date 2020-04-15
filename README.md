[![Maintainability](https://api.codeclimate.com/v1/badges/42e8a34f839ca0c5ec45/maintainability)](https://codeclimate.com/github/code-vedas/mutils/maintainability)
![](https://ruby-gem-downloads-badge.herokuapp.com/mutils?type=total&color=brightgreen)
[![Gem Version](https://badge.fury.io/rb/mutils.svg)](https://badge.fury.io/rb/mutils)
[![Coverage Status](https://coveralls.io/repos/github/Code-Vedas/mutils/badge.svg?branch=master)](https://coveralls.io/github/Code-Vedas/mutils?branch=master)
[![Build Status](https://travis-ci.com/code-vedas/mutils.svg?branch=master)](https://travis-ci.com/code-vedas/mutils)
# Mutils
## Introduction
`mutils` is collection of useful modules for `ruby on rails` which is tested and benchmarked against high load.

These collection of modules are built by developer for developers :-)
# Table of Contents

* [Features](#features)
* [Installation](#installation)
* [Usage](#usage)
  * [Rails Generator](#rails-generator)
  * [Attributes](#attributes)
  * [Relations](#relations)
  * [Conditional Attributes](#conditional-attributes)
  * [Conditional Relations](#conditional-relations)
  * [Attributes Block](#attributes-blocks)
  * [Attributes Block with Params](#attributes-blocks-with-params)
  * [Custom Methods](#custom-methods)
  * [Name Tag](#name-tag)
  * [Sample Usage](#sample-usage)

## Features
* Simple declaration syntax similar to Active Model Serializer
* Realtionships support `belongs_to', `has_many`, `has_one`
* Block style attributes with params

## Installation

Add this line to your application's Gemfile:
```ruby
gem 'mutils'
```
And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install mutils

## Usage 

### Rails Generator
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

### Attributes
Attributes are fields in the model itself. You can reference them by below example
```ruby
# frozen_string_literal: true

# User Serializer
class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :id, :first_name, :last_name, :email
  ## OR
  attribute :email, {always_include: true} ## this will allow to selectively include email
end
```
### Relations
Relations such as `has_many`, `belongs_to`, `has_one` can be used as follows
1. Every relation must be provided with their own serializer
2. `always_include` option can be used to instruct `Serializer` to always include this relation
3. `always_include` by default is disabled, relations which are not `always_include` can be included while using the serializer. Refer to next section for this usage
4. `label` option can be used to override model class name while serializing
```ruby
# frozen_string_literal: true

# User Serializer
class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :id, :first_name, :last_name, :email
  
  belongs_to :company, serializer: CompanySerializer, always_include: true
  ##OR
  belongs_to :company, serializer: CompanySerializer, always_include: true, label: 'organization'   ##<== important to give singular name
  
  has_many :comments, serializer: CommentSerializer
  has_one :account, serializer: AccountSerializer
  
  def full_name
    "#{scope.first_name} #{scope.last_name}"
  end
end
```
### Conditional Attributes
Attributes are fields in the model itself. You can reference them by below example
```ruby
# frozen_string_literal: true

# User Serializer
class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :id, :first_name, :last_name
  attribute :email, if: proc { |scope| scope.name == 'mutils' } ## Email will only serialize if user's name is 'mutils'
end
```
    in proc {|scope|}, scope is object which is being serialized
### Conditional Relations
Attributes are fields in the model itself. You can reference them by below example
```ruby
# frozen_string_literal: true

# User Serializer
class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :id, :first_name, :last_name
  has_many :comments, serializer: CommentSerializer, if: proc { |scope| scope.name == 'mutils' } ## comments will only serialize if user's name is 'mutils'
  belongs_to :account, serializer: AccountSerializer, if: proc { |scope| scope.name != 'mutils' } ## account will only serialize if user's name is not 'mutils'
end
```
    in proc {|scope|}, scope is object which is being serialized    
### Attributes Blocks
While writting attribute a block can be provided for useful transformations like `full_name` as shown below
```ruby
# frozen_string_literal: true

# User Serializer
class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :id, :first_name, :last_name, :email
  attribute :full_name do |object|
    "#{object.first_name} #{object.last_name}"
  end
end
```
### Attributes Blocks with Params
While writting attribute a block can be provided for useful transformations like `full_name` as shown below
```ruby
# frozen_string_literal: true

# User Serializer
class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :id, :first_name, :last_name, :email
  attribute :is_owner do |object,params|
    params[:owner].id == object.id ? true:false
  end
end
```
```ruby
# in controller

user = current_user
owner = owner_user
render json: UserSerializer.new(user,{params:{owner:owner}})
```
### Custom Methods
Custom methods used in Serializer can be useful for cases as below.
`scope` will be available to reference object in Serializer in below case its `user`

```ruby
# frozen_string_literal: true

# User Serializer
class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :id, :first_name, :last_name, :email
  ###
  custom_methods :full_name
  ## OR
  custom_method :full_name, {always_include: true}   ## this will allow to selectively include full_name
  ### 
  
  def full_name
    "#{scope.first_name} #{scope.last_name}"
  end
end
```
### Name Tag
name_tag is used to provide custom name to serializer output keys for json

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

### Sample Usage

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

Everyone interacting in the Mutils project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/code-vedas/mutils/blob/master/CODE_OF_CONDUCT.md).
