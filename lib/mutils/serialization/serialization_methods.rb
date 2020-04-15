# frozen_string_literal: true

# Module Mutils
module Mutils
  module Serialization
    # Module SerializationCore
    module SerializationMethods
      def self.included(base)
        base.extend ClassMethods
      end

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
            value = { method: type == 'method', always_include: true }
            attributes_to_serialize[attr] = value
          end
        end

        def attribute(method_name, options = {}, &proc)
          raise "if: should be a Proc object for attribute #{method_name}" if options[:if] && (options[:if].class.to_s != 'Proc')

          if proc.class.to_s == 'Proc'
            self.attributes_to_serialize_blocks = {} if attributes_to_serialize_blocks.nil?
            options[:block] = proc
            attributes_to_serialize_blocks[method_name] = options
          else
            add_single_attribute(method_name, options, 'attribute')
          end
        end

        def custom_method(method_name, options = {})
          add_single_attribute(method_name, options, 'method')
        end

        def add_single_attribute(method_name, options, type)
          self.attributes_to_serialize = {} if attributes_to_serialize.nil?
          always_include = options[:always_include].nil? ? false : options[:always_include]
          value = { method: type == 'method', always_include: always_include, if: options[:if] }
          attributes_to_serialize[method_name] = value
        end

        def relationship(relationship_name, options = {})
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
          raise "if: should be a Proc object for attribute #{relationship_name}" if options[:if] && (options[:if].class.to_s != 'Proc')

          options[:serializer] = Object.const_get class_name.to_s
          options[:option_name] = option_name
          options[:label] = options[:label]
          options
        end

        def class_exists?(class_name)
          klass = Object.const_get class_name.to_s rescue nil
          klass && defined?(klass) && klass.is_a?(Class)
        end
      end
    end
  end
end
