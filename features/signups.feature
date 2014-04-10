@javascript @signup_page
Feature: Sign Up
  Scenario: Success
    When user filled form with valid information
    Then click sign up button
      And redirect him to top5 hotels page

  Scenario: Fail
    When click sign up button
    Then see fields errors
