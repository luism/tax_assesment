class Parser
  attr_reader :string

  IMPORTED = 'imported'.freeze

  EXCLUDE_ITEMS = %w(chocolate chocolates pills food medical book books)

  def initialize(string)
    @string = string
  end

  def execute
    {
      quantity: get_quantity,
      import: imported?,
      exclude: exclude?,
      description: get_description,
      price: get_price
    }
  end

  def get_quantity
    string.split[0].to_i
  end

  def imported?
    string.include? IMPORTED
  end

  def get_description
    end_point = string.split.size - 2
    string.split[1...end_point].join(' ')
  end

  def get_price
    string.split[-1].to_f
  end

  def exclude?
    (get_description.split & EXCLUDE_ITEMS).any?
  end
end