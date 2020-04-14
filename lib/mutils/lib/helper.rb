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
      end

      def underscore(string)
        inflector_object.underscore string
      end

      def pluralize(string)
        inflector_object.pluralize string
      end

      def collection?(object)
        object.respond_to?(:size) && !object.respond_to?(:each_pair)
      end

      private

      attr_accessor :inflector_object
    end
  end
end
