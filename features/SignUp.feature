Feature: Allow new users to sign-up

  Background: the following users are in the User Model and I am at the sign-up page
#    Given the following users have been added:
#      | handle            | password | password_confirmation  |
#      | iykysia@uiowa.edu | test123  | test123                |
#      | admin             | test123  | test123                |
    Given I'm at the sign up page

  Scenario: valid user sign-up
    When I'm at the sign up page
    And I sign up with "iykysia@uiowa.edu" as a handle and "test123" as a password and press submit
    Then I expect to have successfully signed up as "iykysia@uiowa.edu"

  Scenario: valid user sign-up
    When I'm at the sign up page
    And I sign up with "iykysia@uiowa.edu" as a handle and "test123" as a password and press submit
    Then I expect to have successfully signed up as "iykysia@uiowa.edu"
