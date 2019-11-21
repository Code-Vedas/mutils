require 'mutils/version'
require 'active_support/concern'
require 'active_support/dependencies/autoload'
require 'mutils/serialization/serialization_includes'
require 'mutils/serialization/serialization_methods'
require 'mutils/serialization/base_serializer'

module Mutils
  class Error < StandardError
  end
end
