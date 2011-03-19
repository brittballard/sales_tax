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
    products.each do |product|
      @receipt += product.describe_yourself + "\r\n"
      sales_tax += product.tax
      price = product.price
    end
    
    @receipt += "Sales Taxes: " + sprintf("%.2f", sales_tax) + "\r\n"
    @receipt += "Total: " + sprintf("%.2f", price)
  end
end