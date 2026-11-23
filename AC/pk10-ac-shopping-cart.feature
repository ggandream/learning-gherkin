@PK10
Feature: Shopping Cart
    As a customer
    I want to manage the products in my cart
    so that I can adjust my purchase before checking Scenario Outline:

    #Acceptance Criterio:
    #AC1: Products can be added from the product page
    #AC2: Quantities can be changed and products removed
    #AC3: Subtotals and total update immediately
    #AC4: Quantity never exceeds available stock
    #AC5: Cart is kept after logging out and back in

    Background:
        Given I am logged in the website

    @AC1
    Scenario: Add a product to an empty cart from the product page
        Given I am on the product page of "Laptop Backpack"
        And my cart is empty
        When I add the product to the cart
        Then "Laptop Backpack" is in the shopping cart with quantity 1
        And the cart counter shows 1

    @AC2
    Scenario: Increase the quantity of a product in the cart
        Given I have "Laptop Backpack" in the shopping cart with quantity 1
        And I am on the shopping cart view
        When I increase the quantity of "Laptop Backpack" by 1
        Then "Laptop Backpack" shows a quantity of 2
        And the cart counter shows 2
