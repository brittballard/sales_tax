class Product
  attr_accessor :description, :price_before_tax
  attr_reader :tax_rate_calculator
  
  def initialize(description, price, tax_decorators=[], tax_calculator_factory=TaxCalculatorFactory)
    raise ArgumentError.new("description required.") if description.nil?
    raise ArgumentError.new("price required.") if price.nil?
    
    @description = description
    @price_before_tax = price
    @tax_rate_calculator = tax_calculator_factory.load_tax_calculator(tax_decorators)
  end
  
  def tax
    @tax_rate_calculator.calculate(@price_before_tax)
  end
  
  def price
    @price_before_tax + tax
  end
  
  def describe_yourself
    description.strip
  end
end