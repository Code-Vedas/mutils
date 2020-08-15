# frozen_string_literal: true

# Module Mutils
module Mutils
  module Serialization
    # Module Results
    module Results
      # Module Attributes
      module Main
        def generate_hash
          if scope
            if scope_is_collection?
              options[:child] = true
              scope.map { |inner_scope| self.class.new(inner_scope, options).generate_hash }
            else
              hashed_result(Lib::ResultHash.new)
            end
          else
            {}
          end
        end

        def hashed_result(result_hash)
          fetch_block_attributes(self.class.attributes_to_serialize_blocks, result_hash)
          fetch_attributes(self.class.attributes_to_serialize, result_hash)
          hash_relationships(self.class.relationships, result_hash)

          result_hash.hash
        end

        def check_if_included(s_options, key)
          return s_options[:if].call(scope, options[:params]) unless s_options[:if].nil? || scope_is_collection?

          s_options[:always_include] || options[:includes]&.include?(key)
        end

        def scope_is_collection?
          Lib::Helper.instance.collection? scope
        end

        def class_name
          if scope_is_collection?
            Lib::Helper.instance.pluralize(format_class_name(scope[0]))
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
end
