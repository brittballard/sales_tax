Dir[File.dirname(__FILE__) + "/*.rb"].each do |file|
  load file if !file.include?(File.basename(__FILE__))
end

class Helpers
  def self.build_cart(row_data, shopping_cart)
    decorators = []
    decorators << "exempt" if row_data[3].strip.rstrip == "true"
    decorators << "import" if row_data[2].strip.rstrip == "true"
    shopping_cart.add(Product.new(row_data[1], Float(row_data[4]), decorators))
  end

  def self.process_file_line(line, counter, shopping_cart)
    counter = counter - 1 if line =~ /Quantity\s*\|Item\s*\|Imported\s*\|Exempt\s*\|Price\s*/
    counter = counter + 1
    
    if line =~ /\d+\s*\|[\w\s]+\s*\|(true|false)\s*\|(true|false)\s*\|\d+\.\d{2}\s*/
      row_data = line.split("|")
      Helpers.build_cart(row_data, shopping_cart) if !row_data.nil?
    end
    
    counter
  end
end

File.open(File.dirname(__FILE__) + "/shopping_carts.txt", "r") do |infile|
  shopping_cart = ShoppingCart.new
  counter = 0
  
  while (line = infile.gets)
    counter = Helpers.process_file_line(line, counter, shopping_cart)
  end
  
  if(counter == shopping_cart.products.count)
    shopping_cart.checkout
    puts shopping_cart.receipt
  else
    puts counter
    puts shopping_cart.products.count
    puts "The shopping_carts.txt file provided is in an invalid format."
  end
end