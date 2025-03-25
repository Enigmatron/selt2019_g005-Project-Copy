Feature: Allow logged in users to comment on a topic of their choice

    As a logged in user I am able to go to a topic
    on the topic i am able to leave a comment

  Background: the following users are in the User Model and I am at the login page
    Given the following users have been added:
      | handle            | password |  password_confirmation|
      | iykysia@uiowa.edu | test123  |    test123            |
      | admin             | test123  |    test123            |
    Given the following topics have been added:
      | header               | subject |
      | Cat Sux             | Dogs    |
    Given That I'm at the login page

  Scenario: Comment creation
    When I have logged in with "iykysia@uiowa.edu" handle and "test123" password
    And I navigate to the topic, "Cat Sux" and I comment "cats are teh best"
    Then I expect to have my comment, "cats are teh best" posted on the topic "Cat Sux"
