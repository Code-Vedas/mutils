# frozen_string_literal: true

# Module Mutils
module Mutils
  module Serialization
    # Module SerializationIncludes
    module SerializationIncludes
      extend ActiveSupport::Concern
      included do
        class << self
          attr_accessor :serializer_name,
                        :include_root,
                        :relationships,
                        :attributes_to_serialize
        end
      end
    end
  end
end
