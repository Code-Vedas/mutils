# frozen_string_literal: true
require 'json/ext'
# module Mutils
module Mutils
  module Serialization
    # BaseSerializer
    class BaseSerializer
      include Mutils::Serialization::SerializationIncludes
      include Mutils::Serialization::SerializationMethods
      include Mutils::Serialization::SerializationResults
      attr_accessor :scope, :options, :mutex

      def initialize(object, options = {})
        options[:child] = false unless options[:child]
        self.scope = object
        self.options = options
        self.mutex = Mutex.new
      end

      def as_json(_options = {})
        if options[:child] || !self.class.include_root
          to_h
        else
          { class_name => to_h }
        end
      end

      def to_h
        generate_hash
      end

      def to_json(_options = {})
        JSON.generate(as_json, options)
      end

      def to_xml(_options = {})
        to_h.to_xml(root: class_name, skip_instruct: true, indent: 2)
      end

      def as_xml(_options = {})
        to_xml
      end
    end
  end
end