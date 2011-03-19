class TaxRateCalculator
  attr_accessor :tax_rate, :calculator
  
  def initialize(calculator_to_decorate, tax_rate)
    raise ArgumentError.new("tax_rate must be less than 1.") if tax_rate > 1
    
    @calculator = calculator_to_decorate
    @tax_rate = tax_rate
  end
  
  def calculate
    calculator.nil? ? tax_rate : (tax_rate + calculator.calculate).round(10)
  end
end