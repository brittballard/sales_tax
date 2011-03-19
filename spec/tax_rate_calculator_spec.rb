require 'spec_helper'

describe TaxRateCalculator do
  describe 'tax_rate_calculator attributes and methods' do
    it 'should respond to tax_rate, calculator, and calculate' do
      TaxRateCalculator.new(nil, 0.1).should respond_to(:tax_rate, :calculator, :calculate)
    end
  end
  
  describe 'decorator initializer' do
    it 'should throw an exception if a value of greater than 1 is passed' do
      lambda { TaxRateCalculator.new(nil, 50) }.should raise_exception(ArgumentError, "tax_rate must be less than 1.")
    end
    
    it 'should set the tax rate and calculator attributes when instantiated with instance of itself and a decimal as arguments' do
      decorated_calculator = TaxRateCalculator.new(nil, 0.1)
      calculator = TaxRateCalculator.new(decorated_calculator, 0.1)
      calculator.calculator.should == decorated_calculator
      calculator.tax_rate.should == 0.1
    end
  end
  
  describe 'calculate' do
    it 'should return tax_rate when no decorator class is sent as an argument' do
      calculator = TaxRateCalculator.new(nil, 0.1)
      calculator.calculate.should == 0.1
    end
    
    it 'should return tax_rate plus decoroator\'s tax_rate when decorator is provided as an argument' do
      calculator = TaxRateCalculator.new(TaxRateCalculator.new(nil, 0.10), 0.15)
      calculator.calculate.should == 0.25
    end
    
    it 'should return 0 when decorator\'s tax_rate is the inverse of it\'s own' do
      calculator = TaxRateCalculator.new(TaxRateCalculator.new(nil, 0.1), -0.1)
      calculator.calculate.should == 0.0
    end
  end
end