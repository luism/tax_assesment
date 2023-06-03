require_relative '../../lib/parser'

RSpec.describe Parser, "execute" do
  let(:excluded_items) {  %w(chocolate chocolates pills food medical book books) }
  let(:result) { described_class.new(line, excluded_items).execute }

  context 'when is a goods and not imported' do
    let(:line) { '1 music CD at 16.49' }
    let(:expected_result) {
      {
        description: 'music CD',
        exclude: false,
        import: false,
        price: 16.49,
        quantity: 1
      }
    }

    it 'expect to returns a hash with the right data' do
      expect(result).to include(expected_result)
    end
  end

  context 'when is a goods and it is imported' do
    let(:line) { '1 imported music CD at 16.49' }
    let(:expected_result) {
      {
        description: 'imported music CD',
        exclude: false,
        import: true,
        price: 16.49,
        quantity: 1
      }
    }

    it 'expect to returns a hash with the right data' do
      expect(result).to include(expected_result)
    end
  end

  context 'when it is a excluded good and not imported' do
    let(:line) { '1 box of chocolates at 10.00' }
    let(:expected_result) {
      {
        description: 'box of chocolates',
        exclude: true,
        import: false,
        price: 10.0,
        quantity: 1
      }
    }

    it 'expect to returns a hash with the right data' do
      expect(result).to include(expected_result)
    end
  end

  context 'when it is a excluded good and it is imported' do
    let(:line) { '1 imported box of chocolates at 10.00' }
    let(:expected_result) {
      {
        description: 'imported box of chocolates',
        exclude: true,
        import: true,
        price: 10.0,
        quantity: 1
      }
    }

    it 'expect to returns a hash with the right data' do
      expect(result).to include(expected_result)
    end
  end
end