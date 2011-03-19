require 'spec_helper'

describe TaxRateCalculatorFactory do
  describe 'tax_rate_calculator_factory methods' do
    it 'should have a load_tax_rate_calculator method in it\'s metaclass' do
      TaxRateCalculatorFactory.should respond_to(:load_tax_rate_calculator)
    end
  end
  
  describe 'load_tax_rate_calculator' do
    it 'should return a tax_rate_calculator that returns a tax rate of 10% if no value is passed' do
      calculator = TaxRateCalculatorFactory.load_tax_rate_calculator
      calculator.calculate.should == 0.1
    end
    
    it 'should return a tax_rate_calculator that returns a tax rate of 0% if the value [food] is passed' do
      calculator = TaxRateCalculatorFactory.load_tax_rate_calculator(%w[food])
      calculator.calculate.should == 0
    end
  end
end