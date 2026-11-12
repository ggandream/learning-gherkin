
Feature: Name of the story

  Background:

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
