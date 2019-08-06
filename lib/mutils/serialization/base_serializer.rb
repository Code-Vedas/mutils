module Mutils
  module Serialization
    # BaseSerializer
    module BaseSerializer
      extend ActiveSupport::Concern
      include Mutils::Serialization::SerializationCore

      def initialize(object, options = {})
        self.class.scope = object
        self.class.options = options
      end

      def as_json(options = {})
        super(options)
        if scope_is_collection?
          array = []
          self.class.scope.each_with_index do |r, index|
            self.class.array_index = index
            array << hashed_result
          end
          array
        else
          hashed_result
        end
      end

      def hashed_result
        hash = {}
        if self.class.attributes_to_serialize
          self.class.attributes_to_serialize.keys.each do |f|
            hash[f] = scope[self.class.attributes_to_serialize[f]]
          end
        end

        if self.class.method_to_serialize
          self.class.method_to_serialize.keys.each do |f|
            hash[f] = send(self.class.method_to_serialize[f])
          end
        end

        if self.class.belongs_to_relationships
          self.class.belongs_to_relationships.keys.each do |f|
            always_include = self.class.belongs_to_relationships[f][:always_include]
            always_include = always_include && always_include == true
            if always_include || (self.class.options[:includes] && self.class.options[:includes].include?(f))
              klass = self.class.belongs_to_relationships[f][:serializer]
              hash[f] = klass.new(scope.send(f)).as_json
            end
          end
        end

        if self.class.has_many_relationships
          self.class.has_many_relationships.keys.each do |f|
            always_include = self.class.belongs_to_relationships[f][:always_include]
            always_include = always_include && always_include == true
            if always_include || (self.class.options[:includes] && self.class.options[:includes].include?(f))
              klass = self.class.has_many_relationships[f][:serializer]
              hash[f] = klass.new(scope.send(f)).as_json
            end
          end
        end
        hash
      end

      def scope_is_collection?
        self.class.scope.respond_to?(:size) && !self.class.scope.respond_to?(:each_pair)
      end

      class_methods do
        def attributes(*attributes_list)
          self.attributes_to_serialize = {} if attributes_to_serialize.nil?
          attributes_list.each { |attr| attributes_to_serialize[attr] = attr } if attributes_list
        end

        def custom_methods(*method_list)
          self.method_to_serialize = {} if method_to_serialize.nil?
          method_list.each { |attr| method_to_serialize[attr] = attr } if method_list
        end

        def belongs_to(relationship_name, options = {})
          if options[:serializer].nil?
            raise "Serializer is Required for belongs_to :#{relationship_name}.\nDefine it like:\nbelongs_to :#{relationship_name}, serializer: SERIALIZER_CLASS"
          end
          raise 'Serializer class not defined' unless class_exists? options[:serializer]

          self.belongs_to_relationships = {} if belongs_to_relationships.nil?
          belongs_to_relationships[relationship_name] = options
        end

        def has_many(relationship_name, options = {})
          if options[:serializer].nil?
            raise "Serializer is Required for has_many :#{relationship_name}.\nDefine it like:\nhas_many :#{relationship_name}, serializer: SERIALIZER_CLASS"
          end
          raise 'Serializer class not defined' unless class_exists? options[:serializer]

          self.has_many_relationships = {} if has_many_relationships.nil?
          has_many_relationships[relationship_name] = options
        end

        alias_method :has_one, :belongs_to

        def class_exists?(class_name)
          eval("defined?(#{class_name}) && #{class_name}.is_a?(Class)") == true
        end
      end

      private

      def scope
        if scope_is_collection?
          self.class.scope[self.class.array_index]
        else
          self.class.scope
        end
      end
    end
  end
end