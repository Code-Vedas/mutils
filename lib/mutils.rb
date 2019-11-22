require_relative 'mutils/version'
require 'active_support/concern'
require_relative 'mutils/serialization/serialization_results'
require_relative 'mutils/serialization/serialization_includes'
require_relative 'mutils/serialization/serialization_methods'
require_relative 'mutils/serialization/base_serializer'

module Mutils
  class Error < StandardError
  end
end
