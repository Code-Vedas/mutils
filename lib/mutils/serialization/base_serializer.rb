module Serialization
  # BaseSerializer
  module BaseSerializer
    extend ActiveSupport::Concern
    include SerializationCore

    def initialize(object)
      self.class.scope = object
    end

    def as_json(options = {})
      super(options)
      hash = {}
      self.class.attributes_to_serialize.keys.each do |f|
        hash[f] = self.class.scope[self.class.attributes_to_serialize[f]]
      end if self.class.attributes_to_serialize

      self.class.method_to_serialize.keys.each do |f|
        hash[f] = send(self.class.method_to_serialize[f])
      end if self.class.method_to_serialize
      hash
    end

    class_methods do
      def attributes(*attributes_list)
        self.attributes_to_serialize = {} if self.attributes_to_serialize.nil?
        attributes_list.each do |attr|
          attributes_to_serialize[attr] = attr
        end if attributes_list
      end

      def custom_methods(*method_list)
        self.method_to_serialize = {} if self.method_to_serialize.nil?
        method_list.each do |attr|
          method_to_serialize[attr] = attr
        end if method_list
      end
    end

    private
    def scope
      self.class.scope
    end
  end
end