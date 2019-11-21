# frozen_string_literal: true

# module Mutils
module Mutils
  module Serialization
    # BaseSerializer
    class BaseSerializer
      include Mutils::Serialization::SerializationIncludes
      include Mutils::Serialization::SerializationMethods
      attr_accessor :scope, :options

      def initialize(object, options = {})
        self.scope = object
        self.options = options
      end

      def as_json(options = {})
        form_result
      end

      def to_h
        form_result
      end

      def form_result
        if scope_is_collection?
          scope.map { |local_scope| hashed_result(local_scope) }
        else
          hashed_result(scope)
        end
      end

      def hashed_result(local_scope)
        hash = {}
        if local_scope
          attributes_to_serialize = self.class.attributes_to_serialize
          attributes_to_serialize&.keys&.each do |f|
            hash[f] = local_scope.send(attributes_to_serialize[f])
          end

          method_to_serialize = self.class.method_to_serialize
          method_to_serialize&.keys&.each do |f|
            hash[f] = send(method_to_serialize[f], local_scope)
          end

          belongs_to_relationships = self.class.belongs_to_relationships
          hash = hash.merge hash_relationships(local_scope, belongs_to_relationships)

          has_many_relationships = self.class.has_many_relationships
          hash = hash.merge hash_relationships(local_scope, has_many_relationships)
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

      def scope_is_collection?
        scope.respond_to?(:size) && !scope.respond_to?(:each_pair)
      end

      def get_object
        scope
      end
    end
  end
end