class TaxCalculator
  attr_reader :tax_rate, :calculator
  
  def initialize(calculator_to_decorate, tax_rate)
    raise ArgumentError.new("tax_rate must be less than 1.") if tax_rate > 1
    
    @calculator = calculator_to_decorate
    @tax_rate = tax_rate
  end
  
  def calculate(price)
    raw_tax = calculator.nil? ? (price * tax_rate * 20).round.to_f / 20 : ((tax_rate * price) * 20).round.to_f / 20 + calculator.calculate(price)
    raw_tax < price * tax_rate ? (raw_tax + 0.05).round(2) : raw_tax.round(2)
  end
end