---
title: Usage
nav_order: 5
permalink: /usage
---

# Usage

## Basic attributes

Use `attributes` when fields should always be included.

```ruby
class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :id, :first_name, :last_name, :email
end
```

```ruby
UserSerializer.new(user).to_h
```

## Optional single attributes

Use `attribute` for a single field that should be opt-in unless you set `always_include: true`.

```ruby
class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :id, :first_name
  attribute :email
end
```

```ruby
UserSerializer.new(user).to_h
# => { id: 1, first_name: "Ada" }

UserSerializer.new(user, includes: [:email]).to_h
# => { id: 1, first_name: "Ada", email: "ada@example.com" }
```

This also works with a proc shorthand:

```ruby
class UserSerializer < Mutils::Serialization::BaseSerializer
  attribute :object_id, &:id
end
```

## Computed methods

Use `custom_methods` for computed fields that should always be included.

```ruby
class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :first_name, :last_name
  custom_methods :full_name

  def full_name
    "#{scope.first_name} #{scope.last_name}"
  end
end
```

Use `custom_method` for an opt-in computed field:

```ruby
class HouseSerializer < Mutils::Serialization::BaseSerializer
  custom_method :house_tag

  def house_tag
    "#{scope.name}--#{scope.number}"
  end
end
```

```ruby
HouseSerializer.new(house, includes: [:house_tag]).to_h
```

## Block attributes

Use a block when the serialized value is easiest to express inline.

```ruby
class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :first_name, :last_name

  attribute :full_name do |user|
    "#{user.first_name} #{user.last_name}"
  end
end
```

If you pass `params:`, the block can receive them as the second argument:

```ruby
class UserSerializer < Mutils::Serialization::BaseSerializer
  attribute :is_owner do |user, params|
    params[:owner].id == user.id
  end
end

UserSerializer.new(user, params: { owner: current_user }).to_h
```

## Conditional inclusion

Both attributes and relationships accept `if: proc`.

The proc can take:

- `|scope|`
- `|scope, params|`

Example:

```ruby
class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :id, :first_name
  attribute :email, if: proc { |scope, params| params[:show_email] == true }
end

UserSerializer.new(user).to_h
UserSerializer.new(user, params: { show_email: true }).to_h
```

## Relationships

Mutils supports `belongs_to`, `has_one`, and `has_many`.

Every relationship must declare a serializer:

```ruby
class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :id, :first_name

  belongs_to :company, serializer: CompanySerializer, always_include: true
  has_one :account, serializer: AccountSerializer
  has_many :comments, serializer: CommentSerializer
end
```

Relationship inclusion rules:

- relationships are opt-in by default
- set `always_include: true` to include them every time
- use `includes:` to request optional relationships

```ruby
UserSerializer.new(user, includes: [:account, :comments]).to_h
```

## Relationship labels

Use `label:` to rename the serialized key:

```ruby
class UserSerializer < Mutils::Serialization::BaseSerializer
  belongs_to :company, serializer: CompanySerializer, label: "organization"
end
```

The output key becomes `:organization`.

For collections, Mutils pluralizes the label automatically.

## Root naming

Use `name_tag` to control the root key used by `as_json` and `to_json`.

```ruby
class UserSerializer < Mutils::Serialization::BaseSerializer
  name_tag "person", true
  attributes :id, :first_name
end
```

```ruby
UserSerializer.new(user).as_json
# => { "person" => { ... } }
```

Common forms:

- `name_tag "person", true`
  include a root key on the top-level serializer
- `name_tag "person", false`
  set the serializer name but do not wrap the top-level output
- `name_tag "person"`
  same as `false`
- no `name_tag`
  use the serialized object's class name

For collections with a root key, Mutils pluralizes the configured name.

## Output methods

Use the output method that matches your call site:

- `to_h`
  returns a Ruby hash or array
- `as_json`
  returns a hash, optionally wrapped with a root key at the top level
- `to_json`
  returns a JSON string

Examples:

```ruby
UserSerializer.new(user).to_h
UserSerializer.new(user).as_json
UserSerializer.new(user).to_json
UserSerializer.new(users).to_h
```

## Complete example

```ruby
class CountrySerializer < Mutils::Serialization::BaseSerializer
  attributes :name
end

class HouseSerializer < Mutils::Serialization::BaseSerializer
  custom_methods :house_tag

  def house_tag
    "#{scope.name}--#{scope.number}"
  end
end

class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :first_name, :last_name
  custom_methods :full_name
  has_many :houses, serializer: HouseSerializer, always_include: true
  belongs_to :country, serializer: CountrySerializer, always_include: true
  attribute :object_id, &:id

  def full_name
    "#{scope.first_name} #{scope.last_name}"
  end
end

UserSerializer.new(user).to_h
UserSerializer.new(user, includes: [:object_id]).to_json
```

## Notes

- `includes:` matches the declared field name, not the renamed `label:`
- nested relationship serializers run independently with their own serializer declarations
- passing a collection to the serializer returns an array from `to_h`
