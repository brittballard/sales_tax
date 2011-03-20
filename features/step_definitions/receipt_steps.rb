Dir.foreach(File.dirname(__FILE__) + "/../../app/") do |f| 
  require File.dirname(__FILE__) + "/../../app/" + f if f =~ /\w+\.rb/
end

shopping_cart = nil

Given /^A customer with a shoping cart like:$/ do |product_table|
  shopping_cart = ShoppingCart.new
  
  product_table.hashes.each do |hash|
    decorators = []
    decorators << "exempt" if hash["Exempt"] == "true"
    decorators << "import" if hash["Imported"] == "true"
    
    shopping_cart.add(Product.new(hash["Item"], Float(hash["Price"]), decorators))
  end
end

When /^They check out$/ do
  shopping_cart.checkout
end

Then /^The receipt should read:$/ do |string|
  shopping_cart.receipt.should == string
end