require 'spec_helper'

describe Product do
  describe "product attributes and methods" do
    it "should have a description, price, tax_rate_calculator, and tax_decorators" do
      Product.new.should respond_to(:description, :price, :tax_rate_calculator, :tax_decorators)
    end
  end
end
