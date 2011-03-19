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
      cart.receipt.should == "dummy product : 110.00"
    end
  end
end