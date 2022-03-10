# frozen_string_literal: true

# Module Mutils
module Mutils
  # Module SerializationCore
  module Serialization
    # Module Methods
    module Methods
      # Module Main
      module Main
        def name_tag(name_tag, root = nil)
          self.serializer_name = name_tag
          self.include_root = root
        end

        def class_exists?(class_name)
          klass = Mutils::Lib::Helper.instance.constantize(class_name.to_s)
          klass && defined?(klass) && klass.is_a?(Class)
        rescue StandardError
          false
        end
      end
    end
  end
end
