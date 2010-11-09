Feature: Cards

  Scenario: Editing a card
    Given the "SOM" set has been added
    And the "Venser, the Sojourner" card has been added to that set

    When I go to the edit page for that card
    And I fill in the following:
      | Name            | Dark Wizard        |
      | Mana cost       | 2B                 |
      | Type            | Creature - Wizard  |
      | Number          | 12                 |
      | Power/Toughness | 1/1                |
    And I fill in "Rules text" with "Flying"
    And I uncheck "White"
    And I uncheck "Blue"
    And I uncheck "Black"
    And I select "Common" from "Rarity"
    And I press "Save changes"
    Then I should see "Card was updated, thanks!"