# frozen_string_literal: true

# Module Mutils
module Mutils
  module Serialization
    # Module Results
    module Results
      # Module Relations
      module Relations
        def hash_relationships(relationships_array, result_hash)
          relationships = relationships_array&.compact
          relationships&.each do |key, s_options|
            hash_relationship(key, s_options, result_hash)
          end
        end

        def hash_relationship(key, s_options, result_hash)
          object = scope.send(key)
          name = s_options[:label]
          Lib::Helper.instance.collection?(object) && (name = Lib::Helper.instance.pluralize(name))
          name = name.to_sym
          check_if_included(s_options, key) && (result_hash[name] = Lib::Helper.instance.constantize(s_options[:serializer]).new(object).to_h)
        end
      end
    end
  end
end
