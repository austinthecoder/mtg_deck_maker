Feature: Sets

  Scenario: Adding a valid set
    When I go to the new set page
    And I fill in the following:
      | Name            | Scars of Mirrodin |
      | Number of cards | 249               |
    And I select "2010" from "mtg_set_released_at_1i"
    And I select "October" from "mtg_set_released_at_2i"
    And I select "1" from "mtg_set_released_at_3i"
    And I press "Add this set"
    Then I should see "Set was added, thanks!"



  Scenario: Adding an invalid set
    When I go to the new set page
    And I press "Add this set"
    Then I should see "Name can't be blank"
    And I should see "Number of cards must be set"



  Scenario: Viewing all sets (when there are none)
    When I go to the sets page
    Then I should see "There are no sets!"
    And I should see "Add a set"



  Scenario: Viewing all sets (when there are some)
    Given the "SOM" set has been added
    And the "ZEN" set has been added

    When I go to the sets page
    Then I should see the sets table, which looks like:
      | Name              | Date Released |
      | Scars of Mirrodin | Oct 01, 2010  |
      | Zendikar          | Oct 02, 2009  |



  # Scenario: Editing a set
  #   Given the "SOM" set has been added
  #
  #   When I go to the sets page
  #   And I follow "edit" for that set
  #   And I fill in the following:
  #     | Name            | Worldwake |
  #     | Number of cards | 145       |
  #   And I select "2010" from "mtg_set_released_at_1i"
  #   And I select "February" from "mtg_set_released_at_2i"
  #   And I select "5" from "mtg_set_released_at_3i"