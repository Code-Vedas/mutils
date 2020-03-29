# frozen_string_literal: true

# Module Mutils
module Mutils
  module Serialization
    # Module SerializationCore
    module SerializationMethods
      extend ActiveSupport::Concern
      # Module ClassMethods
      module ClassMethods
        def name_tag(name_tag, root = nil)
          self.serializer_name = name_tag
          self.include_root = root
        end

        def attributes(*attributes_list)
          parse_attributes_methods(attributes_list, 'attributes')
        end

        def custom_methods(*attributes_list)
          parse_attributes_methods(attributes_list, 'method')
        end

        def parse_attributes_methods(list, type)
          self.attributes_to_serialize = {} if attributes_to_serialize.nil?
          list&.each do |attr|
            value = {method: type == 'method', always_include: true}
            attributes_to_serialize[attr] = value
          end
        end

        def attribute(method_name, always_include = false)
          add_single_attribute(method_name, always_include, 'attribute')
        end

        def custom_method(method_name, always_include = false)
          add_single_attribute(method_name, always_include, 'method')
        end

        def add_single_attribute(method_name, always_include, type)
          self.attributes_to_serialize = {} if attributes_to_serialize.nil?
          value = {method: type == 'method', always_include: always_include}
          attributes_to_serialize[method_name] = value
        end

        def relationship(relationship_name, options = {}, option_name = 'belongs_to')
          options = prepare_options(relationship_name, options, option_name)
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

          options[:serializer] = class_name.to_s.constantize
          options[:option_name] = option_name
          options
        end

        def class_exists?(class_name)
          klass = class_name.to_s.constantize rescue nil
          klass && defined?(klass) && klass.is_a?(Class)
        end

      end
    end
  end
end
