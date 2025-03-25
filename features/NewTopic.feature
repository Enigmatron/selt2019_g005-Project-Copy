Feature: Allow logged in users to make a new topic

  a logged in user is able to navigate to the topic creation page
  and submit a new topic

Background: the following users are in the User Model and I am at the login page
#  Given the following users have been added:
#    | handle            | password | password_confirmation  |
#    | iykysia@uiowa.edu | test123  | test123                |
#    | admin             | test123  | test123                |
#  Given That I'm at the login page

Scenario: Topic creation
  When I'm at the sign up page
  And I sign up with "iykysia@uiowa.edu" as a handle and "test123" as a password and press submit
  Then I expect to have successfully signed up as "iykysia@uiowa.edu"
  Given That I'm at the login page
  When I have logged in with "iykysia@uiowa.edu" handle and "test123" password
  And I navigate to the topic creation page and create the new topic, "has anyone seen this dog"
  Then I expect to have my topic, "has anyone seen this dog" posted
