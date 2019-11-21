# frozen_string_literal: true

# Module Mutils
module Mutils
  module Serialization
    # Module SerializationIncludes
    module SerializationIncludes
      extend ActiveSupport::Concern
      included do
        class << self
          attr_accessor :method_to_serialize,
                        :attributes_to_serialize,
                        :array_index,
                        :belongs_to_relationships,
                        :has_many_relationships
        end
      end
    end
  end
end