require 'spec_helper'

describe OpenStore do
  def check_product(product, tax, description)
    product.tax.should == tax
    product.describe_yourself.should == description
  end
  
  describe 'build_cart' do
    def check_shopping_cart(row_data, product_count, tax, description)
      OpenStore.build_cart(row_data, @shopping_cart)
      @shopping_cart.products.count.should == product_count
      check_product(@shopping_cart.products.first, tax, description)
    end

    before do
      @shopping_cart = ShoppingCart.new
    end
    
    it 'should add one product to the shopping cart with the description test and price 100.00 with a tax rate of 10%' do
      row_data = ["1", "test 123", "false", "false", "100.00"]
      check_shopping_cart(row_data, 1, 10.00, "test 123")
    end
    
    it 'should add one product to the shopping cart with the description test and price 100.00 with a tax rate of 15%' do
      row_data = ["1", "test", "true", "false", "100.00"]
      check_shopping_cart(row_data, 1, 15.00, "test")
    end
    
    it 'should add one product to the shopping cart with the description test and price 100.00 with a tax rate of 5%' do
      row_data = ["1", "test", "true", "true", "100.00"]
      check_shopping_cart(row_data, 1, 5.00, "test")
    end
    
    it 'should add one product to the shopping cart with the description test and price 100.00 with a tax rate of 0%' do
      row_data = ["1", "test", "false", "true", "100.00"]
      check_shopping_cart(row_data, 1, 0.00, "test")
    end
    
    it 'should add two products to the shopping cart with the description test and price 100.00 with a tax rate of 10%' do
      row_data = ["2", "test", "false", "false", "100.00"]
      check_shopping_cart(row_data, 2, 10.00, "test")
      check_product(@shopping_cart.products.last, 10.00, "test")
    end
  end
  
  describe 'process_file_line' do
    def check_shopping_cart(line, product_count, tax, description, counter, counter_expectation)
      OpenStore.process_file_line(line, counter, @shopping_cart).should == counter_expectation
      @shopping_cart.products.count.should == product_count
      check_product(@shopping_cart.products.first, tax, description)
    end
    
    before do
      @shopping_cart = ShoppingCart.new
    end
    
    it 'should add one product to the shopping cart with the description test and price 100.00 with a tax rate of 10% and the counter should increase by one' do
      line = "1 | test | false | false | 100.00"
      check_shopping_cart(line, 1, 10.00, "test", 0, 1)
    end
    
    it 'should add one product to the shopping cart with the description test and price 100.00 with a tax rate of 15% and the counter should increase by one' do
      line = " 1 | test | true | false | 100.00"
      check_shopping_cart(line, 1, 15.00, "test", 1, 2)
    end
    
    it 'should add one product to the shopping cart with the description test and price 100.00 with a tax rate of 5% and the counter should increase by one' do
      line = "   1 |test|true | true | 100.00"
      check_shopping_cart(line, 1, 5.00, "test", 0, 1)
    end
    
    it 'should add one product to the shopping cart with the description test and price 100.00 with a tax rate of 0% and the counter should increase by one' do
      line = "1|test|false|true|100.00"
      check_shopping_cart(line, 1, 0.00, "test", 0, 1)
    end
    
    it 'should add two products to the shopping cart with the description test and price 100.00 with a tax rate of 10% and the counter should increase by two' do
      line = "2|test|false|false|100.00"
      check_shopping_cart(line, 2, 10.00, "test", 0, 2)
      check_product(@shopping_cart.products.last, 10.00, "test")
    end
    
    describe 'sad paths' do
      it 'should not add a product to the cart, but the counter should increase by one because the price is in an invalid format' do
        line = "2|test|false|false|100.000"
        OpenStore.process_file_line(line, 0, @shopping_cart).should == 1
      end
      
      it 'should not add a product to the cart, but the counter should increase by one because exempt is in an invalid format' do
        line = "2|test|false|falsey|100.00"
        OpenStore.process_file_line(line, 0, @shopping_cart).should == 1
      end
      
      it 'should not add a product to the cart, but the counter should increase by one because import is in an invalid format' do
        line = "2|test|falsey|false|100.00"
        OpenStore.process_file_line(line, 0, @shopping_cart).should == 1
      end
      
      it 'should not add a product to the cart, but the counter should increase by one because quantity is in an invalid format' do
        line = "a|test|falsey|false|100.00"
        OpenStore.process_file_line(line, 0, @shopping_cart).should == 1
      end
    end
  end
end
