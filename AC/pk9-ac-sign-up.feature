@PK-9
Feature: Sign Up

  As a visitor
  I want to create an account
  So that I can buy products in the store

  #Acceptance Criteria:
  #AC1: Account is created with a valid name, email and password
  #AC2: Verification email is sent after registration
  #AC3: Password requirements are shown and validated in real time
  #AC4: Already registered emails are rejected

  Rule: Account is created with a valid name, email and password and a verification email is sent after registration

    Background:
      Given I am on the sign up page

    @AC1
    Scenario: An account is created successfully
      Given there is no account with email "ana@gmail.com"
      When I sign up with name "Ana", email "ana@gmail.com", password "Secret123!"
      Then my account is created
      And I see the message "Welcome, please verify your email"

  Rule: A verification email is sent after registration
    @AC2
    Scenario: Verification email is sent after sign up
      Given there is no account with email "ana@gmail.com"
      When I sign up with name "Ana", email "ana@gmail.com", password "Secret123!"
      Then a verification email is sent to "ana@gmail.com"

  Rule: Password requirements are shown and validated in real time
    @AC3
    Scenario Outline: Password without <requirement> is flagged
      Given I entered name "Ana" and email "ana@gmail.com"
      When I type password "<password>" in the password field
      Then I see a message "Password must have 8 characters and a mix of numbers and letters"
      Examples:
        | password | requirement          |
        | 123abc   | 8 characters minimum |
        | abcdefgh | number               |
        | 12345678 | letter               |

    @AC3
    Scenario: Password with 8 characters or more, and a mix of letters and numbers
      Given I entered name "Ana" and email "ana@gmail.com"
      When I type password "Secret123!" in the password field
      Then I don't see the message "Password must have 8 characters and a mix of numbers and letters"

  Rule: A registered email is rejected
    Background:
      Given I am on the sign up page
      And there is an account with email "ana@gmail.com"

    @AC4
    Scenario: Sign up is rejected when the email is already registered
      When I sign up with name "Ana", email "ANA@gmail.com", password "Secret123!"
      Then I remain on the sign up page
      And I see the message "Please verify your data"
      And no new account is created
      And no verification email is sent