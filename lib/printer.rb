class Printer
  def initialize

  end

  def show(title, items, total = 0.0, taxes = 0.0)
    title.tap do |string|
      string << "\n"
      items.each do |item|
        string << "#{item[:quantity]} #{item[:description]}: #{item[:quantity] * (item[:price] + item[:tax]).round(2)}\n"
      end
      string << "Sales Taxes: #{taxes}"
      string << "\n"
      string << "Total: #{total}"
    end
  end
end