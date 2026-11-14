@PK-8
Feature: Login
  As a registered user
  I want to log in with my email and password
  So that I can access my account

  #Acceptance Criteria:
  #AC1: A user with an active account can log in with a valid email and password and is redirected to the home page.
  #AC2: Error messages do not reveal which field is incorrect
  #AC3: Session persists after page reload
  #AC4: Account is temporarily locked after 5 failed attempts

  Rule: Users with valid credentials can access their account
    Background:
      Given I am on the login page

    @AC1
    Scenario: Successful login with valid credentials
      Given I have an active account with email "ana@gmail.com"
      When I log in with email "ana@gmail.com" and my valid password
      Then I am redirected to the home page
      And I see my name in the header

    @AC1
    Scenario: Email is not case sensitive
      Given I have an active account with email "ana@gmail.com"
      When I log in with email "ANA@GMAIL.COM" and my valid password
      Then I am redirected to the home page
      And I see my name in the header

  Rule: Error messages do not reveal which field is incorrect
    Background:
      Given I am on the login page

    @AC2
    Scenario: Login fails with incorrect password
      Given I have an active account with email "ana@gmail.com"
      When I log in with email "ana@gmail.com" and an incorrect password
      Then I see the message "It was not possible to log in because the email or password is incorrect."
      And I remain on the login page

    @AC2
    Scenario: Login fails with incorrect email
      Given I have an active account with email "ana@gmail.com"
      When I log in with email "unknown@gmail.com" and any password
      Then I see the message "It was not possible to log in because the email or password is incorrect."
      And I remain on the login page

  Rule: The session persists while the user is logged in

    @AC3
    Scenario: Session persists after page reload
      Given I have an active account with email "ana@gmail.com"
      And I am logged in
      When I reload the page
      Then I see my name in the header
      And I am not redirected to the login page

  Rule: Account is temporarily locked after 5 failed attempts
    Background:
      Given I have an active account with email "ana@gmail.com"
      And I am on the login page

    @AC4
    Scenario: Account is not locked after 4 failed attempts
      When I log in with email "ana@gmail.com" and an incorrect password 4 times in a row
      And I log in with email "ana@gmail.com" and my valid password the 5th time
      Then I am redirected to the home page

    @AC4
    Scenario: Account is locked after 5 failed attempts
      When I log in with email "ana@gmail.com" and an incorrect password 5 times in a row
      Then I see the message "Try after 15 minutes, your account has been locked due to many failed attempts"
      And I cannot log in with email "ana@gmail.com" and my valid password