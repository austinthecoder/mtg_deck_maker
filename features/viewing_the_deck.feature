Feature: Viewing The Deck

  Scenario: With no cards in the deck
    When I go to the deck page
    Then I should see "There are no cards in your deck."



  Scenario: Adding a card to the deck
    Given the "SOM" set has been added
    And the following cards have been added to that set:
      | Trigon of Infestation |

    When I go to the cards page
    And I add "3" of the "Trigon of Infestation" card to the deck
    And I go to the deck page
    Then I should see the table for the deck, which looks like:
      |   |   | Name                  | Cost | Conv. Cost | Type     | Pow./Tgh. |
      | 3 | x | Trigon of Infestation | 4    | 4          | Artifact |           |