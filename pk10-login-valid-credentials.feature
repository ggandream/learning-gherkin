Feature: User Authentication
  As a registered user
  I want to log in with my credentials
  So that I can access my account

  @PK-10 @acceptance-criteria
  Scenario: AC1 - Registered user can log in with valid credentials
    Given a registered user
    When they log in with valid credentials
    Then they access their account

  @PK-10 @AC1 @test-case
  Scenario Outline: TC1 - Successful login with valid credentials
    Given the user is on the login page
    When the user enters username "<username>" and password "<password>"
    And the user submits the login form
    Then the user should be redirected to the home page
    And the see their username

    Examples:
      | username | password |
      | Admin    | admin123 |
      | engineer | sai123   |
