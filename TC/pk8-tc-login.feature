Feature: Login
  As a registered user
  I want to log in with my email and password
  So that I can access my account

  # Story: PK-8
  # Subtasks: PK-10 (valid login), PK-11 (generic error handling), PK-12 (account lockout)
  #   - Exact generic error message
  #   - Format of the remaining lockout time
  #   - Whether the failed-attempts counter also resets when the 15 minutes expire
  #   - What PK-11 covers (its description is identical to PK-10)

  # ---------------------------------------------------------------
  # AC1: User can log in with a valid email and password
  # ---------------------------------------------------------------

  @PK-8 @AC1 @test-case
  Scenario Outline: TC1 - Login with valid email and password
    Given the user is on the login page
    When the user logs in with email "<email>" and password "<password>"
    Then the user should be redirected to the home page

    Examples:
      | email             | password   |
      | admin@example.com | 12345678   |
      | USER@Example.com  | asdfghddaf |

  @PK-8 @AC1 @test-case
  Scenario: TC2 - Password is masked on the login form
    Given the user is on the login page
    When the user types a password
    Then the password should not be displayed in plain text

  # ---------------------------------------------------------------
  # AC2: Error messages do not reveal which field is incorrect
  # ---------------------------------------------------------------

  @PK-8 @PK-10 @AC2 @test-case
  Scenario Outline: TC3 - Generic error message for wrong credentials
    Given the user is on the login page
    When the user logs in with email "<email>" and password "<password>"
    Then the user should see the error "It was not possible to log in because the email or password is incorrect."
    And the password field should be empty

    Examples:
      | email               | password   |
      | admin@example.com   | wrong      |
      | unknown@example.com | <password> |

  @PK-8 @PK-10 @AC2 @test-case
  Scenario: TC4 - Error message is identical for wrong email and wrong password
    Given the user is on the login page
    When the user logs in with a registered email and a wrong password
    And the user logs in with an unregistered email and any password
    Then both attempts should show exactly the same error message

  @PK-8 @PK-10 @AC2 @test-case
  Scenario Outline: TC5 - Submit button is disabled when a field is empty
    Given the user is on the login page
    When the user enters email "<email>" and password "<password>"
    Then the submit button should be disabled

    Examples:
      | email             | password |
      |                   |          |
      | admin@example.com |          |
      |                   | secret   |

  # ---------------------------------------------------------------
  # AC3: Account is temporarily locked after 5 failed attempts
  # ---------------------------------------------------------------

  @PK-8 @PK-12 @AC3 @test-case
  Scenario: TC6 - Account is not locked after 4 failed attempts
    Given a registered user
    When the user enters a wrong password 4 times
    Then the account should not be locked
    And the user can still log in with the correct password

  @PK-8 @PK-12 @AC3 @test-case
  Scenario: TC7 - Account is locked for 15 minutes after 5 failed attempts
    Given a registered user
    When the user enters a wrong password 5 times
    Then the account should be locked
    And the user should see the remaining lockout time
    And logging in with the correct password should still fail

  @PK-8 @PK-12 @AC3 @test-case
  Scenario: TC8 - Failed attempts counter resets after a successful login
    Given a registered user who has failed to log in 4 times
    When the user logs in with valid credentials
    And the user enters a wrong password 4 times
    Then the account should not be locked

  # ---------------------------------------------------------------
  # AC4: Session persists after page reload
  # ---------------------------------------------------------------

  @PK-8 @AC4 @test-case
  Scenario: TC9 - Session persists after page reload
    Given the user has logged in successfully
    When the user reloads the page
    Then the user should still be logged in
    And the user should still be on the home page
