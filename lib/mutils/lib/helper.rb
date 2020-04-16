# frozen_string_literal: true

require 'singleton'
# module Mutils
module Mutils
  module Lib
    # BaseSerializer: inherit this class to get Serializer functionality
    class Helper
      include Singleton

      def initialize
        self.inflector_object = Dry::Inflector.new
        self.pluralize_cache = {}
        self.underscore_cache = {}
        self.constantize_cache = {}
      end

      def underscore(string)
        underscore_cache[string] = inflector_object.underscore string unless underscore_cache[string]
        underscore_cache[string]
      end

      def pluralize(string)
        pluralize_cache[string] = inflector_object.pluralize string unless pluralize_cache[string]
        pluralize_cache[string]
      end

      def constantize(string)
        constantize_cache[string] = Object.const_get string unless constantize_cache[string]
        constantize_cache[string]
      end

      def collection?(object)
        object.respond_to?(:size) && !object.respond_to?(:each_pair)
      end

      private

      attr_accessor :inflector_object, :pluralize_cache, :underscore_cache, :constantize_cache
    end
  end
end
