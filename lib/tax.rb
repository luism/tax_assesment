require_relative 'parser'
require_relative 'printer'

class Tax
  attr_reader :input, :parser, :data, :title, :total_taxes, :total_price, :output

  TAX = 0.1
  IMPORTED_TAX = 0.05
  EXCLUDE_ITEMS = %w(chocolate chocolates pills food medical book books)

  def initialize(input, options = {})
    @input = input
    @parser = parser
    @data = []
    @printer = Printer.new
    @title = "Output #{File.basename(input, ".*").split('_')[1] || ''}".strip
    @total_price = 0.0
    @total_taxes = 0.0
    @output = ''
  end

  def execute
    parse_input
    calculate
    puts show
  end

  def parse_input
    File.foreach(input).each_with_index do |line, i|
      next if i.zero?
      data << apply_taxes(Parser.new(line, EXCLUDE_ITEMS).execute)
    end
  end

  def calculate
    @total_price = data.inject(0.0){|sum, item| sum + item[:quantity]*(item[:price] + item[:tax])}.round(2)
    @total_taxes = data.inject(0.0){|sum, item| sum + item[:quantity]* item[:tax]}.round(2)
  end

  def show
    @output = @printer.show title, data, @total_price, @total_taxes
  end

  def apply_taxes(item)
    tax = item[:exclude] ? 0.0 : (item[:price]*0.1).round(2)
    tax_import = item[:import] ? (item[:price]*0.05).round(2) : 0.0
    item.merge({tax: tax + tax_import})
  end
end




