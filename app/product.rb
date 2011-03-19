class Product
  attr_accessor :description, :price_before_tax
  attr_reader :tax_rate_calculator
  
  def initialize(description, price, tax_decorators=[], tax_rate_calculator_factory=TaxCalculatorFactory)
    @description = description
    @price_before_tax = price
    @tax_rate_calculator = tax_rate_calculator_factory.load_tax_rate_calculator(tax_decorators)
  end
  
  def tax
    @tax_rate_calculator.calculate(@price_before_tax)
  end
  
  def price
    @price_before_tax + tax
  end
  
  def describe_yourself
    description.lstrip.rstrip
  end
end