Feature: Allow not logged in user to login

  As a signed out user
  So that I can post, comment and like topics
  I want to use my credentials to login
  Background: the following users are in the User Model and I am at the login page
    Given the following users have been added:
      | handle            | password | password_confirmation  |
      | iykysia@uiowa.edu | test123  | test123                |
      | admin             | test123  | test123                |
    Given That I'm at the login page

  Scenario: failed login
    When I have logged in with "iykysia" handle and "test" password
    Then I expect to have failed to login as "iykysia"


  Scenario: success login
    When I have logged in with "iykysia@uiowa.edu" handle and "test123" password
    Then I expect to have successfully login as "iykysia@uiowa.edu"
