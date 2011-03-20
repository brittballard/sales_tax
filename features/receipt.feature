Feature: Creating Receipts for Shopping Carts
  In order to communicate to my customers how much money they paid for what goods
  As a shop keeper
  I need to be able to create receipts that communicate the appropriate amount of data
  
  Scenario: A customer has a shopping cart with exempt items and no imported items and domestic items
    Given A customer with a shoping cart like:
    |Quantity |Item         |Imported |Exempt |Price  |
    |1        |book         |false    |true   |12.49  |
    |1        |music CD     |false    |false  |14.99  |
    |1        |chocolate bar|false    |true   |0.85   |
    When They check out
    Then The receipt should read:
      """
      1 book: 12.49
      1 music CD: 16.49
      1 chocolate bar: 0.85
      Sales Taxes: 1.50
      Total: 29.83
      """

  Scenario: A customer has a shopping cart with exempt items and imported items and no domestic items
    Given A customer with a shoping cart like:
    |Quantity |Item                         |Imported |Exempt |Price  |
    |1        |imported box of chocolates   |true     |true   |10.00  |
    |1        |imported bottle of perfume   |true     |false  |47.50  |
    When They check out
    Then The receipt should read:
      """
      1 imported box of chocolates: 10.50
      1 imported bottle of perfume: 54.65
      Sales Taxes: 7.65
      Total: 65.15
      """

  Scenario: A customer has a shopping cart with exempt items and imported items and domestic items
    Given A customer with a shoping cart like:
    |Quantity |Item                             |Imported |Exempt |Price  |
    |1        |imported bottle of perfume       |true     |false  |27.99  |
    |1        |bottle of perfume                |false    |false  |18.99  |
    |1        |packet of headache pills         |false    |true   |9.75   |
    |1        |imported box of chocolates       |true     |true   |11.25  |
    When They check out
    Then The receipt should read:
      """
      1 imported bottle of perfume: 32.19
      1 bottle of perfume: 20.89
      1 packet of headache pills: 9.75
      1 imported box of chocolates: 11.85
      Sales Taxes: 6.70
      Total: 74.68
      """