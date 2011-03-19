class Product
  attr_accessor :description, :price
  attr_reader :tax_rate_calculator
  
  def initialize(description, price, tax_decorators=[])
    @description = description
    @price = price
    @tax_rate_calculator = TaxRateCalculatorFactory.load_tax_rate_calculator(tax_decorators)
  end
end