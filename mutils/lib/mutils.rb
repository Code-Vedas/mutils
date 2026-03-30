# frozen_string_literal: true

require 'dry/inflector'
require_relative 'mutils/version'
require_relative 'mutils/lib/helper'
require_relative 'mutils/lib/result_hash'
require_relative 'mutils/serialization/serialization_results'
require_relative 'mutils/serialization/serialization_includes'
require_relative 'mutils/serialization/serialization_methods'
require_relative 'mutils/serialization/base_serializer'

module Mutils
  class Error < StandardError
  end
end
