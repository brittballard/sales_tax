class TaxCalculatorFactory
  
  def self.load_tax_calculator(tax_decorators=[])
    calculator = TaxCalculator.new(nil, 0.1)
    calculator = TaxCalculator.new(calculator, -0.1) if tax_decorators.include?('exempt')
    calculator = TaxCalculator.new(calculator, 0.05) if tax_decorators.include?('import')
    
    calculator
  end
  
end