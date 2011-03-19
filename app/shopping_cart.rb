class ShoppingCart
  attr_accessor :products, :receipt

  def initialize
    @products = []
    @receipt = ""
  end

  def add(product)
    products << product
  end
  
  def checkout
    sales_tax = 0
    price = 0
    product_hash = {}
    
    products.each do |product|
      if product_hash.key?(product.description + product.price.to_s)
        product_hash[product.description + product.price.to_s] << product
      else
        product_hash[product.description + product.price.to_s] = [product]
      end
    end
    
    product_hash.keys.each do |product|
      total_price = 0
      total_sales_tax = 0
      product_hash[product].each do |p| 
        total_price += p.price
        total_sales_tax += p.tax
      end
      @receipt += product_hash[product].count.to_s + " " + product_hash[product].first.describe_yourself + " : " + sprintf("%.2f", total_price) + "\r\n"
      sales_tax += total_sales_tax
      price += total_price 
    end
    
    @receipt += "Sales Taxes: " + sprintf("%.2f", sales_tax) + "\r\n"
    @receipt += "Total: " + sprintf("%.2f", price)
  end
end