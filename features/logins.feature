@javascript @logins_page
Feature: Log in
  @create_user
  Scenario: Success
    When user fill login form
    Then click button
      And redirect to top5 page

  Scenario: False
    When click button
    Then see error message
