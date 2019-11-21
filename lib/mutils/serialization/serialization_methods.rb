# frozen_string_literal: true

# Module Mutils
module Mutils
  module Serialization
    # Module SerializationCore
    module SerializationMethods
      extend ActiveSupport::Concern
      module ClassMethods
        def attributes(*attributes_list)
          self.attributes_to_serialize = {} if attributes_to_serialize.nil?
          attributes_list&.each { |attr| attributes_to_serialize[attr] = attr }
        end

        def custom_methods(*method_list)
          self.method_to_serialize = {} if method_to_serialize.nil?
          method_list&.each { |attr| method_to_serialize[attr] = attr }
        end

        def belongs_to(relationship_name, options = {})
          if options[:serializer].nil?
            raise "Serializer is Required for belongs_to :#{relationship_name}." \
                  "\nDefine it like:\nbelongs_to :#{relationship_name}, " \
                  'serializer: SERIALIZER_CLASS'
          end
          unless class_exists? options[:serializer]
            raise 'Serializer class not defined'
          end

          self.belongs_to_relationships = {} if belongs_to_relationships.nil?
          belongs_to_relationships[relationship_name] = options
        end

        alias has_one belongs_to

        def has_many(relationship_name, options = {})
          if options[:serializer].nil?
            raise "Serializer is Required for has_many :#{relationship_name}." \
                  "\nDefine it like:\nbelongs_to :#{relationship_name}, " \
                  'serializer: SERIALIZER_CLASS'
          end
          unless class_exists? options[:serializer]
            raise 'Serializer class not defined'
          end

          self.has_many_relationships = {} if has_many_relationships.nil?
          has_many_relationships[relationship_name] = options
        end

        def class_exists?(class_name)
          eval("defined?(#{class_name}) && #{class_name}.is_a?(Class)") == true
        end
      end
    end
  end
end