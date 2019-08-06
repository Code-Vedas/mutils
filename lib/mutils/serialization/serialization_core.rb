module Mutils
  module Serialization
    # Module SerializationCore
    module SerializationCore
      extend ActiveSupport::Concern
      included do
        class << self
          attr_accessor :scope,
                        :method_to_serialize,
                        :attributes_to_serialize
        end
      end
    end
  end
end