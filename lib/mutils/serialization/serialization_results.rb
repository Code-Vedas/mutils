# frozen_string_literal: true

require_relative 'results/main'
require_relative 'results/attributes'
require_relative 'results/relations'
# Module Mutils
module Mutils
  module Serialization
    # Module SerializationResults
    module SerializationResults
      include Mutils::Serialization::Results::Main
      include Mutils::Serialization::Results::Attributes
      include Mutils::Serialization::Results::Relations
    end
  end
end
