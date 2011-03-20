require 'spec_helper'

describe ShoppingCart do
  describe 'shopping_cart attributes and methods' do
    it 'should respond to add and produts' do
      ShoppingCart.new.should respond_to(:add, :products, :checkout, :receipt)
    end
  end
  
  describe 'add' do
    it 'should add a product to the shopping cart' do
      cart = ShoppingCart.new
      product = Product.new("dummy product", 100.00)
      cart.add(product)
      cart.products.first.should == product
    end
    
    it 'should cause the list of products in the cart to increase everytime I add a new product' do
      cart = ShoppingCart.new
      cart.add(Product.new("dummy product", 100.00))
      cart.add(Product.new("dummy product 2", 100.00))
      
      cart.products.count.should == 2
    end
  end
  
  describe 'checkout' do
    it 'should create a receipt' do
      cart = ShoppingCart.new
      cart.add(Product.new("dummy product", 100.00))
      
      cart.checkout
      cart.receipt.should_not be_nil
    end
    
    it 'should create a receipt that consists of all of the products it contains descriptions and price including tax' do
      cart = ShoppingCart.new
      cart.add(Product.new("dummy product", 100.00))
      
      cart.checkout
      cart.receipt.should =~ /1 dummy product: 110.00/
    end
    
    it 'should create a receipt for multiple products with each product on a new line' do
      cart = ShoppingCart.new
      cart.add(Product.new("dummy product", 100.00))
      cart.add(Product.new("dummy product", 80.00))
      
      cart.checkout
      cart.receipt.should =~ /1 dummy product: 110.00\n1 dummy product: 88.00/
    end
    
    it 'should create a receipt that displays tax information' do
      cart = ShoppingCart.new
      cart.add(Product.new("dummy product", 100.00))
      
      cart.checkout
      cart.receipt.should =~ /Sales Taxes: 10.00/
    end
    
    it 'should create a receipt that displays the price of the goods purchased' do
      cart = ShoppingCart.new
      cart.add(Product.new("dummy product", 100.00))
      
      cart.checkout
      cart.receipt.should =~ /Total: 110.00/
    end
    
    it 'should not show a product with the same price and same description twice and should show quanitity when applicable' do
      cart = ShoppingCart.new
      cart.add(Product.new("dummy product", 100.00))
      cart.add(Product.new("dummy product", 100.00))
            
      cart.checkout
      cart.receipt.should =~ /2 dummy product: 220.00/
    end
    
    it 'should create a receipt that displays product information followed by sales tax followed by total' do
      cart = ShoppingCart.new
      cart.add(Product.new("dummy product", 100.00))
      
      cart.checkout
      cart.receipt.should == "1 dummy product: 110.00\nSales Taxes: 10.00\nTotal: 110.00"
    end
    
    it 'should raise an exception if checkout is called twice' do
      cart = ShoppingCart.new
      cart.add(Product.new("dummy product", 100.00))
      
      cart.checkout
      lambda{ cart.checkout }.should raise_exception(Exception, "A shopping cart can only be checkedout once.")
    end
  end
end