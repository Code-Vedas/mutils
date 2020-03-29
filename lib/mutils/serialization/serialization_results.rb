# frozen_string_literal: true

# Module Mutils
module Mutils
  module Serialization
    # Module SerializationResults
    module SerializationResults
      def generate_hash
        if scope
          if scope_is_collection?
            options[:child] = true
            scope.map { |inner_scope| self.class.new(inner_scope, options).generate_hash }
          else
            hashed_result
          end
        else
          {}
        end
      end

      def hashed_result
        [fetch_attributes(self.class.attributes_to_serialize),
         hash_relationships(self.class.relationships)].reduce(&:merge)
      end

      def fetch_attributes(attributes)
        hash = {}
        attributes&.keys&.each do |key|
          check_if_included(attributes, key) && (hash[key] = attributes[key][:method] ? send(key) : scope.send(key))
        end
        hash
      end

      def hash_relationships(relationships_array)
        relationships = relationships_array&.compact
        hash = {}
        relationships&.keys&.each { |key| check_if_included(relationships, key) && (hash[key] = relationships[key][:serializer].new(scope.send(key)).to_h) }
        hash
      end

      def check_if_included(relationships, key)
        always_include = relationships[key][:always_include] == true
        always_include || options[:includes]&.include?(key)
      end

      def scope_is_collection?
        scope.respond_to?(:size) && !scope.respond_to?(:each_pair)
      end

      def class_name
        if scope_is_collection?
          format_class_name(scope[0]).pluralize
        else
          format_class_name(scope)
        end
      end

      def format_class_name(object)
        if self.class.serializer_name&.length&.positive?
          self.class.serializer_name
        else
          object.class.to_s.downcase
        end
      end
    end
  end
end
