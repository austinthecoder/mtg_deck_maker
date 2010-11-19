Feature: Cards

  Scenario: Editing a card
    Given a set
    And a card in that set

    When I go to the edit page for that card
    And I fill in the following:
      | Name            | Dark Wizard        |
      | Mana cost       | 2B                 |
      | Type            | Creature - Wizard  |
      | Number          | 12                 |
      | Power/Toughness | 1/1                |
      | Loyalty         |                    |
    And I fill in "Rules text" with "Flying"
    And I uncheck "White"
    And I uncheck "Blue"
    And I check "Black"
    And I select "Common" from "Rarity"
    And I press "Save changes"
    Then I should see "Card was updated, thanks!"