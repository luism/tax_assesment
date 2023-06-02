class Printer
  def initialize

  end

  def show(title, items, total = 0.0, taxes = 0.0)
    puts title
    items.each do |item|
      puts "#{item[:quantity]} #{item[:description]}: #{item[:quantity] * (item[:price] + item[:tax]).round(2)}"
    end
    puts "Sales Taxes: #{taxes}"
    puts "Total: #{total}"
  end
end