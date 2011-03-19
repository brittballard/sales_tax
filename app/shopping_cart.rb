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
    products.each do |product|
      @receipt += product.describe_yourself
    end
  end
end