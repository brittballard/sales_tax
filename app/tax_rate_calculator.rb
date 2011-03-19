class TaxRateCalculator
  attr_accessor :tax_rate, :calculator
  
  def initialize(calculator_to_decorate, tax_rate)
    @calculator = calculator_to_decorate
    @tax_rate = Float(tax_rate) / 100 unless tax_rate.nil?
  end
  
  def calculate
    calculator.nil? ? tax_rate : tax_rate + calculator.calculate
  end
end