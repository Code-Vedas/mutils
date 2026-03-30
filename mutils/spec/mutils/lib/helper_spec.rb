# frozen_string_literal: true

RSpec.describe Mutils::Lib::Helper do
  describe '#underscore' do
    it 'reuses cached inflections when the same key is requested twice' do
      helper = described_class.instance

      expect(helper.underscore('HouseName')).to eq('house_name')
      expect(helper.underscore('HouseName')).to eq('house_name')
    end
  end

  describe '#pluralize' do
    it 'reuses cached inflections when the same key is requested twice' do
      helper = described_class.instance

      expect(helper.pluralize('house')).to eq('houses')
      expect(helper.pluralize('house')).to eq('houses')
    end
  end
end
