# frozen_string_literal: true

# Module Mutils
module Mutils
  module Serialization
    # Module Results
    module Results
      # Module Attributes
      module Attributes
        def fetch_block_attributes(attributes, result_hash)
          attributes&.each do |key, s_options|
            arg = [scope]
            arg << options[:params] || {} unless s_options[:block].parameters.flatten.include?(:rest)

            result_hash[key] = s_options[:block].call(*arg)
          end
        end

        def fetch_attributes(attributes, result_hash)
          attributes&.each do |key, s_options|
            check_if_included(s_options, key) && (result_hash[key] = s_options[:method] ? send(key) : scope.send(key))
          end
        end
      end
    end
  end
end
