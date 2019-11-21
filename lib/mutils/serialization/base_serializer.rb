# frozen_string_literal: true

# module Mutils
module Mutils
  module Serialization
    # BaseSerializer
    class BaseSerializer
      include Mutils::Serialization::SerializationIncludes
      include Mutils::Serialization::SerializationMethods
      include Mutils::Serialization::SerializationResults
      attr_accessor :scope, :options

      def initialize(object, options = {})
        self.scope = object
        self.options = options
      end

      def as_json(_options = {})
        form_result
      end

      def to_h
        form_result
      end

      def scope_is_collection?
        scope.respond_to?(:size) && !scope.respond_to?(:each_pair)
      end
    end
  end
end