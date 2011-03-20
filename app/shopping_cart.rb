class ShoppingCart
  attr_reader :products, :receipt

  def initialize
    @products = []
    @receipt = ""
  end

  def add(product)
    products << product
  end
  
  def checkout
    if @receipt.empty?
      sales_tax = 0
      price = 0
      product_hash = {}
    
      products.each do |product|
        if product_hash.key?(product.description + product.price.to_s)
          product_hash[product.description + product.price.to_s][:price] += product.price
          product_hash[product.description + product.price.to_s][:total] += 1
          product_hash[product.description + product.price.to_s][:tax] += product.tax
        else
          product_hash[product.description + product.price.to_s] = { :price => product.price, :total => 1, :tax => product.tax, :description => product.describe_yourself }
        end
      
        sales_tax += product.tax
        price += product.price
      end
    
      product_hash.keys.each do |product|
        @receipt += "#{product_hash[product][:total].to_s} #{product_hash[product][:description]}: #{sprintf("%.2f", product_hash[product][:price])}\n"
      end
    
      @receipt += "Sales Taxes: #{sprintf("%.2f", sales_tax)}\n"
      @receipt += "Total: #{sprintf("%.2f", price)}"
    else
      raise Exception.new("A shopping cart can only be checkedout once.")
    end
  end
end