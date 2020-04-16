# frozen_string_literal: true

# module Mutils
module Mutils
  module Lib
    # ResultHash: Store result using this class.
    class ResultHash

      def initialize
        self._hash = {}
      end

      def []=(key, value)
        _hash[key] = value
      end

      def hash
        _hash
      end

      private

      attr_accessor :_hash
    end
  end
end
