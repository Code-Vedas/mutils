# frozen_string_literal: true

# Module Mutils
module Mutils
  module Serialization
    # Module SerializationResults
    module SerializationResults

      def generate_hash
        if scope
          if scope_is_collection?
            scope.map { |local_scope| hashed_result(local_scope) }
          else
            hashed_result(scope)
          end
        else
          {}
        end
      end

      def hashed_result(local_scope)
        relationships = [self.class.belongs_to_relationships, self.class.has_many_relationships]
        [fetch_attributes(local_scope, self.class.attributes_to_serialize&.keys),
         invoke_sends(self, self.class.method_to_serialize&.keys, local_scope),
         hash_relationships(local_scope, relationships)].reduce(&:merge)
      end

      def fetch_attributes(object, keys)
        hash = {}
        threads = []
        keys&.each do |key|
          threads << Thread.new { hash[key] = object.send(key) }
        end
        threads.map(&:join)
        hash
      end

      def invoke_sends(object, keys, local_scope)
        hash = {}
        threads = []
        keys&.each do |key|
          threads << Thread.new { hash[key] = object.send(key, local_scope) }
        end
        threads.map(&:join)
        hash
      end

      def hash_relationships(local_scope, relationships_array)
        relationships = relationships_array.compact.reduce(&:merge)
        hash = {}
        relationships&.keys&.each do |key|
          if check_if_included(relationships, key)
            klass = relationships[key][:serializer]
            hash[key] = klass.new(local_scope.send(key)).to_h
          end
        end
        hash
      end

      def check_if_included(relationships, key)
        always_include = relationships[key][:always_include]
        always_include = always_include.nil? ? false : always_include == true
        always_include || (options[:includes]&.include?(key))
      end

      def scope_is_collection?
        scope.respond_to?(:size) && !scope.respond_to?(:each_pair)
      end
    end
  end
end