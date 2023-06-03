require_relative '../../lib/tax'

RSpec.describe Tax, "execute" do
  let(:item1) { { description: 'book', price: 12.49, qty: 1, tax: 0.00 } }
  let(:item2) { { description: 'music CD', price: 14.99, qty: 1, tax: (14.99 * Tax::TAX).round(2) } }
  let(:item3) { { description: 'chocolate bar', price: 10.0, qty: 1, tax: 0.0 } }
  let(:item4) { { description: 'imported bottle perfum', price: 10.0, qty: 1, tax: (10.00 * Tax::TAX + 10.00 * Tax::IMPORTED_TAX).round(2) } }
  let(:item5) { { description: 'imported chocolate bar', price: 10.0, qty: 1, tax: (10.00 * Tax::IMPORTED_TAX).round(2) } }
  let(:items) { [item1, item2, item3, item4, item5] }
  let(:items_str) { items.map{|i| "#{i[:qty]} #{i[:description]}: #{(i[:price]+i[:tax]).round(2)}"}.join("\n") }
  let(:tax) { Tax.new('input_1.txt')}
  let(:total) { items.inject(0.0) { |sum, i| sum + (i[:price] + i[:tax]).round(2) * i[:qty] } }
  let(:total_taxes) { items.inject(0.0) { |sum, i| sum + i[:tax] * i[:qty] } }

  let(:expected_output) {
<<-TEXT
Output 1
#{items_str}
Sales Taxes: #{total_taxes}
Total: #{total}
TEXT
  }

  before do
    @input1 = items.inject(['Input 1']) { |arr, i| arr << "#{i[:qty]} #{i[:description]} at #{i[:price]}" }
    allow(File).to receive(:foreach).and_return(@input1)
    tax.execute
  end

  it 'returns the right string' do
    expect(tax.output).to eq(expected_output.strip)
  end

  it 'calculate the right total price' do
    expect(tax.total_price).to eq(total)
  end

  it 'calculate the right total taxes' do
    expect(tax.total_taxes).to eq(total_taxes)
  end
end