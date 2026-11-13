@PK-8
Feature: Login

    @AC1
    Scenario: Successful login with valid credentials
        Given I have a n active account with email "ana@gmail.com"
        And I am on the login page
        When I log in with my valid credentials
        Then I am redirected to the home page
        And I see my name in the header

    @AC2
    Scenario: Email is not case sensitive
        Given I have an active account with email "ana@gmail.com"
        And I am on the login page
        When I log in with email "ANA@GMAIL.COM" and my valid password
        Then I am redirected to the home page
        And I see my name in the header

    @AC3
    Scenario: Session persists after page reload
        Given I am logged in
        When I reload the page
        Then I see my name in the header

    @AC4
    Scenario: Login fails with incorrect password
        Given I have an active account with email "ana@gmail.com"
        And I am on the login page
        When I log in with email "ana@gmail.com" and an incorrect password
        Then I see the message "It was not possible to log in because the email or password is incorrect."
        And I reamin on the login page