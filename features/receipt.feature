Feature: Creating Receipts for Shopping Carts
  In order to communicate to my customers how much money they paid for what goods
  As a shop keeper
  I need to be able to create receipts that communicate the appropriate amount of data
  
  Scenario: A customer has a shopping cart with food and no imported items
    Given A customer with a shoping cart like:
    |Quantity |Item         |Price  |
    |1        |book         |12.49  |
    |1        |music        |14.99  |
    |1        |chocolate bar|0.85   |
    When I check her out
    Then I should have the following line items:
    |Quantity |Item         |Price  |
    |1        |book         |12.49  |
    |1        |music CD     |16.49  |
    |1        |chocolate bar|0.85   |
  