# frozen_string_literal: true

# Module Mutils
module Mutils
  module Serialization
    # Module SerializationCore
    module SerializationMethods
      extend ActiveSupport::Concern
      # Module ClassMethods
      module ClassMethods
        def name_tag(name_tag, root = false)
          self.serializer_name = name_tag
          self.include_root = root
        end

        def attributes(*attributes_list)
          self.attributes_to_serialize = {} if attributes_to_serialize.nil?
          attributes_list&.each { |attr| attributes_to_serialize[attr] = attr }
        end

        def custom_methods(*method_list)
          self.method_to_serialize = {} if method_to_serialize.nil?
          method_list&.each { |attr| method_to_serialize[attr] = attr }
        end

        def check_for_class(option_name, relationship_name, class_name)
          if class_name.nil?
            raise "Serializer is Required for belongs_to :#{relationship_name}." \
                  "\nDefine it like:\n#{option_name} :#{relationship_name}, " \
                  'serializer: SERIALIZER_CLASS'
          end
          return if class_exists? class_name

          raise "Serializer class not defined for relationship: #{relationship_name}"
        end

        def belongs_to(relationship_name, options = {}, option_name = 'belongs_to')
          options = prepare_options(relationship_name, options, option_name)
          self.belongs_to_relationships = {} if belongs_to_relationships.nil?
          belongs_to_relationships[relationship_name] = options
        end

        alias has_one belongs_to

        def has_many(relationship_name, options = {}, option_name = 'has_many')
          options = prepare_options(relationship_name, options, option_name)
          self.has_many_relationships = {} if has_many_relationships.nil?
          has_many_relationships[relationship_name] = options
        end

        def prepare_options(relationship_name, options, option_name)
          check_for_class(option_name, relationship_name, options[:serializer])
          options[:serializer] = options[:serializer].to_s.constantize
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
