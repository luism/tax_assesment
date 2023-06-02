require_relative 'Parser'
require_relative 'Printer'

class Tax
  attr_reader :input, :parser, :data, :title

  def initialize(input, options = {})
    @input = input
    @parser = parser
    @data = []
    @printer = Printer.new
    @title = "Output #{File.basename(input, ".*").split('_')[1] || ''}".strip
  end

  def execute
    parse_input
    calculate
  end

  def parse_input
    File.foreach(input).each_with_index do |line, i|
      next if i.zero?
      data << Parser.new(line).execute
    end
  end

  def calculate
    data_with_tax = data.map{|item| apply_taxes item }
    total_price = data_with_tax.inject(0.0){|sum, item| sum + item[:quantity]*(item[:price] + item[:tax])}.round(2)
    total_taxes = data_with_tax.inject(0.0){|sum, item| sum + item[:quantity]* item[:tax]}.round(2)
    @printer.show title, data_with_tax, total_price, total_taxes
  end

  def apply_taxes(item)
    tax = (item[:price]*0.1).round(2)
    tax = 0.0 if item[:exclude]
    tax = (tax + item[:price]*0.05).round(2) unless item[:imported]
    item.merge({tax: tax})
  end
end




