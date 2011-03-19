require 'spec_helper'

describe Product do
  before do
    TaxCalculatorFactory.stub!(:load_tax_rate_calculator).and_return(TaxCalculator.new(nil, 0.1))
  end
  
  describe "product attributes and methods" do
    it "should have a description, price, tax_rate_calculator, and tax_decorators" do
      Product.new(nil, nil).should respond_to(:description, :price_before_tax, :tax_rate_calculator, :price, :tax)
    end
  end
  
  describe 'initializer' do
    it 'should load a tax_rate_calculator' do
      Product.new(nil, nil).tax_rate_calculator.should be_an_instance_of(TaxCalculator)
    end
  end
  
  describe 'describe_yourself' do
    it 'should return a composed of the name and price of the product' do
      Product.new("imported bottle of medicine", 100.00, [], TaxCalculatorFactory).describe_yourself.should == "imported bottle of medicine"
    end
  end
  
  describe 'price' do
    it 'should return the price of the product with tax' do
      product = Product.new("imported bottle of medicine", 100.00, [], TaxCalculatorFactory)
      product.price.should == 110.00
    end
  end
  
  describe 'tax' do
    it 'should return the tax that is going to be charged on this product' do
      product = Product.new("imported bottle of medicine", 100.00, [], TaxCalculatorFactory)
      product.tax.should == 10.00
    end
  end
end
