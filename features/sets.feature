Feature: Sets

  Scenario: Adding a set
    When I go to the new set page
    And I fill in the following:
      | Name | My Cool Set |
    And I press "Add this set"
    Then I should see "Set was added, thanks!"