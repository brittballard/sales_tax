class TaxRateCalculatorFactory
  
  def self.load_tax_rate_calculator(tax_decorators=[])
    calculator = TaxRateCalculator.new(nil, 0.1)
    calculator = TaxRateCalculator.new(calculator, -0.1) if tax_decorators.include?('exempt')
    calculator = TaxRateCalculator.new(calculator, 0.05) if tax_decorators.include?('import')
    
    calculator
  end
  
end