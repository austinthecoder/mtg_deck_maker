Feature: Viewing cards

  Scenario: Viewing all cards when there are none
    When I go to the cards page
    Then I should see "There are no cards!"
    And I should see "Add a card"



  Scenario: Viewing an individual card
    Given the "SOM" set has been added
    And the "Kemba's Skyguard" card has been added to that set

    When I go to that card's page
    Then I should see the table for that card, which looks like:
      | Name         | Kemba's Skyguard                                                       |
      | Mana Cost    | 1WW                                                                    |
      | Type         | Creature - Cat Knight                                                  |
      | Rules Text   | When Kemba's Skyguard enters the battlefield, you gain 2 life.         |
      | Power/Tough. | 2/2                                                                    |
      | Loyalty      |                                                                        |
      | Rarity       | Common                                                                 |
      | Set          | Scars of Mirrodin                                                      |