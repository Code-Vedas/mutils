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
          raise "if: should be a Proc object for attribute #{relationship_name}" if options[:if] && !options[:if].instance_of?(Proc)

          options = prepare_options(relationship_name, options, __callee__)
          self.relationships = {} if relationships.nil?
          relationships[relationship_name] = options
        end

        alias belongs_to relationship
        alias has_many relationship
        alias has_one relationship

        def prepare_options(relationship_name, options, option_name)
          class_name = options[:serializer]
          if class_name.nil?
            raise "Serializer is Required for belongs_to :#{relationship_name}." \
                    "\nDefine it like:\n#{option_name} :#{relationship_name}, " \
                    'serializer: SERIALIZER_CLASS'
          end
          raise "Serializer class not defined for relationship: #{relationship_name}" unless class_exists? class_name

          options[:serializer] = class_name.to_s
          options[:always_include].nil? ? false : options[:always_include]
          options[:label] = Lib::Helper.instance.underscore options[:label] || relationship_name
          options
        end

      end
    end
  end
end