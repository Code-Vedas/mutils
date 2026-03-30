---
title: Installation
nav_order: 3
permalink: /install
---

# Installation

## Gemfile

Add Mutils to your application:

```ruby
gem "mutils"
```

Install dependencies:

```bash
bundle install
```

## Rails generator

If you are using Rails, Mutils ships with a serializer generator:

```bash
bundle exec rails generate mutils:serializer User id first_name last_name email
```

This creates:

```text
app/serializers/user_serializer.rb
```

Generated example:

```ruby
class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :id, :first_name, :last_name, :email
end
```

## Plain Ruby setup

You can also use Mutils directly in plain Ruby:

```ruby
require "mutils"

class User
  attr_accessor :id, :first_name, :last_name
end

class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :id, :first_name, :last_name
end
```

No Rails dependency is required for runtime serialization.
