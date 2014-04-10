@javascript
Feature: Hotels
  @log_in
  Scenario: User is able to add hotel
    When user click on add_hotel link
    Then he has access to create hotel

  @root_page
  Scenario: User is not able to add hotel
    When user click on add_hotel link
    Then he has receive error message

  @log_in @create_hotel_page
  Scenario: Create hotel
    When user filled hotel form
    Then click on create_hotel button
      And see success message

  @log_in @create_hotel_page
  Scenario: Can't create hotel
    When click on create_hotel button
    Then see errors

  @log_in @create_hotel @show_hotel_page
  Scenario: Only publisher can edit his hotel
    When click edit_hotel button
    Then then he has access to update hotel form

  @log_in @create_hotel @update_hotel_page
  Scenario: Edit hotel
    When publisher click on update_hotel button
    Then see success update message

  @create_user @create_hotel @show_hotel_page
  Scenario: User which not login, cannot edit and destroy his hotels
    Then he not see edit and destroy button

  @log_in @create_hotel @show_hotel_page
  Scenario: Only publisher can destroy his hotel
    When click destroy_hotel button
    Then see success destroy message
