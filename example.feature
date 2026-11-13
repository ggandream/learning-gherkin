
Feature: Name of the story

  Background:
    Given user has an existing account
    And user adds an item to cart
    And user goes into shopping cart page

  Scenario Outline: Gherkin Practice
    Given uper is in UPEX Galaxy
    When uper asks for a “<review>”
    Then Ely should put on the cap
    And he will do a friendly “<review>”
    Examples:
      | review       |
      | Code review  |
      | Story review |
      | TC review    |
      | Git review   |
