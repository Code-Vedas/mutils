# frozen_string_literal: true

# Module Mutils
module Mutils
  # Module SerializationCore
  module Serialization
    # Module Methods
    module Methods
      # Module Relations
      module Relations
        def relationship(relationship_name, options = {})
          raise "if: should be a Proc object for relationship #{relationship_name}" if options[:if] && !options[:if].instance_of?(Proc)

          options = prepare_options(relationship_name, options, __callee__)
          self.relationships = {} if relationships.nil?
          relationships[relationship_name] = options
        end

        alias belongs_to relationship
        alias has_many relationship
        alias has_one relationship

        def prepare_options(relationship_name, options, option_name)
          serializer, always_include, label = options.values_at(:serializer, :always_include, :label)
          serializer = fetch_serializer!(relationship_name, serializer, option_name)

          options.merge(
            serializer: serializer.to_s,
            always_include: default_always_include(always_include),
            label: relation_label(label, relationship_name)
          )
        end

        private

        def fetch_serializer!(relationship_name, serializer, option_name)
          if serializer.nil?
            raise "Serializer is Required for belongs_to :#{relationship_name}." \
                  "\nDefine it like:\n#{option_name} :#{relationship_name}, " \
                  'serializer: SERIALIZER_CLASS'
          end
          raise "Serializer class not defined for relationship: #{relationship_name}" unless class_exists? serializer

          serializer
        end

        def default_always_include(always_include)
          always_include.nil? ? false : always_include
        end

        def relation_label(label, relationship_name)
          Lib::Helper.instance.underscore(label || relationship_name)
        end
      end
    end
  end
end
