require 'spec_helper'

describe Product do
  describe "product attributes and methods" do
    it "should have a description, price, tax_rate_calculator, and tax_decorators" do
      Product.new(nil, nil).should respond_to(:description, :price_before_tax, :tax_rate_calculator, :price, :tax)
    end
  end
  
  describe 'initializer' do
    it 'should load a tax_rate_calculator' do
      Product.new(nil, nil).tax_rate_calculator.should be_an_instance_of(TaxRateCalculator)
    end
  end
  
  describe 'describe_yourself' do
    it 'should return a composed of the name and price of the product' do
      TaxRateCalculatorFactory.stub!(:load_tax_rate_calculator).and_return(TaxRateCalculator.new(nil, 0))
      Product.new("imported bottle of medicine", 100.00, [], TaxRateCalculatorFactory).describe_yourself.should == "imported bottle of medicine : 100.00"
    end
  end
  
  describe 'price' do
    it 'should return the price of the product with tax' do
      TaxRateCalculatorFactory.stub!(:load_tax_rate_calculator).and_return(TaxRateCalculator.new(nil, 0.1))
      product = Product.new("imported bottle of medicine", 100.00, [], TaxRateCalculatorFactory)
      product.price.should == 110.00
    end
  end
  
  describe 'tax' do
    it 'should return the tax that is going to be charged on this product' do
      TaxRateCalculatorFactory.stub!(:load_tax_rate_calculator).and_return(TaxRateCalculator.new(nil, 0.1))
      product = Product.new("imported bottle of medicine", 100.00, [], TaxRateCalculatorFactory)
      product.tax.should == 10.00
    end
  end
end
