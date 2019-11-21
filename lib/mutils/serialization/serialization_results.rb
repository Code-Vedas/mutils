# frozen_string_literal: true

# Module Mutils
module Mutils
  module Serialization
    # Module SerializationResults
    module SerializationResults

      def form_result
        mutex = Mutex.new

        if scope_is_collection?
          scope.map { |local_scope| hashed_result(local_scope, mutex) }
        else
          hashed_result(scope, mutex)
        end
      end

      def hashed_result(local_scope, mutex)
        hash = {}
        if local_scope
          threads = []
          mutex.synchronize do
            threads << Thread.new do
              attributes_to_serialize = self.class.attributes_to_serialize
              attributes_to_serialize&.keys&.each do |f|
                hash[f] = local_scope.send(attributes_to_serialize[f])
              end
            end
          end
          threads << Thread.new do
            mutex.synchronize do
              method_to_serialize = self.class.method_to_serialize
              method_to_serialize&.keys&.each do |f|
                hash[f] = send(method_to_serialize[f], local_scope)
              end
            end
          end
          threads << Thread.new do
            mutex.synchronize do
              belongs_to_relationships = self.class.belongs_to_relationships
              hash = hash.merge hash_relationships(local_scope, belongs_to_relationships)
            end
          end
          threads << Thread.new do
            mutex.synchronize do
              has_many_relationships = self.class.has_many_relationships
              hash = hash.merge hash_relationships(local_scope, has_many_relationships)
            end
          end
          threads.map(&:join)
        end
        hash
      end

      def hash_relationships(local_scope, relationships)
        hash = {}
        relationships&.keys&.each do |f|
          always_include = relationships[f][:always_include]
          always_include = always_include.nil? ? false : always_include == true
          if always_include || (options[:includes]&.include?(f))
            klass = relationships[f][:serializer]
            hash[f] = klass.new(local_scope.send(f)).as_json
          end
        end
        hash
      end
    end
  end
end