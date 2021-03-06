# frozen_string_literal: true

# Module Mutils
module Mutils
  # Module SerializationCore
  module Serialization
    # Module Methods
    module Methods
      # Module Attributes
      module Attributes
        def attributes(*attributes_list)
          parse_attributes_methods(attributes_list, false)
        end

        def custom_methods(*attributes_list)
          parse_attributes_methods(attributes_list, true)
        end

        def parse_attributes_methods(list, is_method)
          self.attributes_to_serialize = {} if attributes_to_serialize.nil?
          list&.each do |attr|
            value = { method: is_method, always_include: true }
            attributes_to_serialize[attr] = value
          end
        end

        def attribute(method_name, options = {}, &proc)
          raise "if: should be a Proc object for attribute #{method_name}" if options[:if] && !options[:if].instance_of?(Proc)

          if proc.instance_of? Proc
            self.attributes_to_serialize_blocks = {} if attributes_to_serialize_blocks.nil?
            options[:block] = proc
            attributes_to_serialize_blocks[method_name] = options
          else
            add_single_attribute(method_name, options, false)
          end
        end

        def custom_method(method_name, options = {})
          add_single_attribute(method_name, options, true)
        end

        def add_single_attribute(method_name, options, is_method)
          self.attributes_to_serialize = {} if attributes_to_serialize.nil?
          always_include = options[:always_include].nil? ? false : options[:always_include]
          value = { method: is_method, always_include: always_include, if: options[:if] }
          attributes_to_serialize[method_name] = value
        end
      end
    end
  end
end
