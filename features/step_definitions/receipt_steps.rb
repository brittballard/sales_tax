Dir.foreach(File.dirname(__FILE__) + "/../../app/") do |f| 
  require File.dirname(__FILE__) + "/../../app/" + f if f =~ /\w+\.rb/
end

@shopping_cart = ShoppingCart.new

Given /^A customer with a shoping cart like:$/ do |product_table|
  # table is a Cucumber::Ast::Table
  product_table.hashes.each do |hash|
    @shopping_cart.add(Product.new(hash))
  end
end

When /^They check out$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^The receipt should read "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end