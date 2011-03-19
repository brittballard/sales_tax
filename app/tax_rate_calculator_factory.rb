class TaxRateCalculatorFactory
  
  def self.load_tax_rate_calculator(tax_decorators=[])
    calculator = TaxRateCalculator.new(nil, 10)
    
    if(tax_decorators.include?('food'))
      calculator = TaxRateCalculator.new(calculator, -10)
    end
    
    calculator
  end
  
end