---
title: Overview & Motivation
nav_order: 2
permalink: /overview
---

# Overview & Motivation

Mutils is a serializer library for Ruby objects. You define a serializer class, list the fields you want, and call `to_h`, `as_json`, or `to_json`.

It is designed for cases where you want:

- explicit serialized output
- serializer-local computed fields
- lightweight conditional inclusion
- straightforward relationship nesting
- a smaller surface area than larger serializer frameworks

## What it owns

Mutils handles:

- collecting scalar fields from the serialized object
- running serializer instance methods as computed fields
- evaluating block-based fields
- nesting related serializers
- producing hash and JSON output
- optional wrapping of the root object under a root key

## What it does not try to do

Mutils does not own:

- controller integration
- caching strategy
- pagination metadata
- JSON:API formatting
- automatic preload or query optimization

Those concerns stay in your application code.

## Main serializer shape

Every serializer inherits from `Mutils::Serialization::BaseSerializer`:

```ruby
class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :id, :email
end
```

The serializer receives:

- the object or collection to serialize
- an optional options hash such as `includes:` or `params:`

Example:

```ruby
UserSerializer.new(user).to_h
UserSerializer.new(user, includes: [:account]).to_json
UserSerializer.new(user, params: { current_user: current_user }).as_json
```

## Collections

Passing a collection returns an array from `to_h` and `as_json` unless you explicitly enable a root wrapper through `name_tag`.

```ruby
UserSerializer.new(users).to_h
# => [{...}, {...}]
```

## Root keys

By default, `as_json` returns the serialized hash directly.

It wraps the top-level output only when `include_root` is enabled through `name_tag`.

```ruby
UserSerializer.new(user).as_json
# => { id: 1, email: "ada@example.com" }
```

```ruby
class UserSerializer < Mutils::Serialization::BaseSerializer
  name_tag "user", true
  attributes :id, :email
end

UserSerializer.new(user).as_json
# => { "user" => { id: 1, email: "ada@example.com" } }
```

If you want to control that behavior, use `name_tag`. See [Usage](/usage).
