# frozen_string_literal: true

require_relative 'methods/main'
require_relative 'methods/relations'
require_relative 'methods/attributes'
# Module Mutils
module Mutils
  module Serialization
    # Module SerializationCore
    module SerializationMethods
      def self.included(base)
        base.extend Methods::Main
        base.extend Methods::Attributes
        base.extend Methods::Relations
      end
    end
  end
end
