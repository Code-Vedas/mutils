---
layout: default
title: Home
nav_order: 1
---

# Mutils

{: .note }

> Mutils is a focused serializer DSL for Ruby and Rails apps. It gives you explicit control over attributes, computed fields, relationships, and JSON root naming without depending on Active Model Serializers.

Mutils centers on one job: turn Ruby objects into predictable hashes or JSON with a small class-based API.

## What it provides

- attribute declarations for model fields
- computed serializer methods
- block-based fields with access to `params`
- `has_many`, `has_one`, and `belongs_to` relationships
- conditional inclusion with `if: proc`
- selective field loading with `includes:`
- optional JSON root keys with `name_tag`
- a Rails generator for serializer scaffolding

## Quick start

```ruby
gem "mutils"
```

```bash
bundle install
```

```ruby
class UserSerializer < Mutils::Serialization::BaseSerializer
  attributes :id, :first_name, :last_name
  custom_methods :full_name

  def full_name
    "#{scope.first_name} #{scope.last_name}"
  end
end
```

```ruby
UserSerializer.new(user).to_h
# => { id: 1, first_name: "Ada", last_name: "Lovelace", full_name: "Ada Lovelace" }
```

## Core ideas

- `attributes` are always included by default
- `attribute` is opt-in by default unless `always_include: true`
- `custom_methods` are always included by default
- `custom_method` is opt-in by default unless `always_include: true`
- relationships are opt-in by default unless `always_include: true`

That split is intentional: bulk declarations default to "include now", while single declarations are useful for optional fields.

## Links

- [Overview & Motivation](./overview)
- [Installation](./install)
- [Usage](./usage)
- [FAQ / Troubleshooting](./faq)
