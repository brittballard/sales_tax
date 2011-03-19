class TaxCalculator
  attr_accessor :tax_rate, :calculator
  
  def initialize(calculator_to_decorate, tax_rate)
    raise ArgumentError.new("tax_rate must be less than 1.") if tax_rate > 1
    
    @calculator = calculator_to_decorate
    @tax_rate = tax_rate
  end
  
  def calculate(price)
    raw_tax = calculator.nil? ? price * tax_rate : (tax_rate * price) + calculator.calculate(price)

    # http://stackoverflow.com/questions/1346257/round-a-ruby-integer-up-to-the-nearest-0-05
    (raw_tax * 20).round.to_f / 20
  end
end