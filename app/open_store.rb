class OpenStore
  def self.build_cart(row_data, shopping_cart)
    decorators = []
    decorators << "exempt" if row_data[3].strip == "true"
    decorators << "import" if row_data[2].strip == "true"
    
    Integer(row_data[0]).times do
      shopping_cart.add(Product.new(row_data[1].strip, Float(row_data[4].strip), decorators))
    end
  end

  def self.process_file_line(line, counter, shopping_cart)
    counter = counter - 1 if line =~ /^\s*Quantity\s*\|\s*Item\s*\|\s*Imported\s*\|\s*Exempt\s*\|\s*Price\s*$/
    counter = counter + 1
    
    if line =~ /^\s*\d+\s*\|\s*[\w\s\d]+\s*\|\s*(true|false)\s*\|\s*(true|false)\s*\|\s*\d+\.\d{2}\s*$/
      row_data = line.split("|")
      counter = counter + (Integer(row_data[0].strip) - 1)
      self.build_cart(row_data, shopping_cart) if !row_data.nil?
    end
    
    counter
  end
  
  def self.process_file(infile, shopping_cart=ShoppingCart.new, counter=0)
    while (line = infile.gets)
      counter = self.process_file_line(line, counter, shopping_cart)
    end

    if(counter == shopping_cart.products.count)
      shopping_cart.checkout
      puts shopping_cart.receipt
    else
      raise ArgumentError.new("The shopping_carts.txt file provided is in an invalid format.")
    end
  end
end