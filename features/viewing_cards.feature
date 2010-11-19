Feature: Viewing cards

  Scenario: Viewing all cards when there are none
    When I go to the cards page
    Then I should see "There are no cards!"
    And I should see "Add a card"



  Scenario: Viewing an individual card
    Given a set named "Fooey"
    And a card in that set with the attributes:
      | Name       | My Card              |
      | Mana Cost  | 1W                   |
      | Type       | Creature             |
      | Rules Text | This card has rules! |
      | Power      | 2                    |
      | Toughness  | 3                    |
      | Loyalty    | 3                    |
      | Rarity     | common               |

    When I go to that card's page
    Then I should see that card's table, i.e.:
      | Name         | My Card              |
      | Mana Cost    | 1W                   |
      | Type         | Creature             |
      | Rules Text   | This card has rules! |
      | Power/Tough. | 2/3                  |
      | Loyalty      | 3                    |
      | Rarity       | Common               |
      | Set          | Fooey                |