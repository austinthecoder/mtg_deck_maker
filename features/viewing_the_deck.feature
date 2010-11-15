Feature: Viewing The Deck

  Scenario: With no cards in the deck
    When I go to the deck page
    Then I should see "There are no cards in your deck."



  Scenario: Adding a card to the deck
    Given a set
    And a card named "Trigon of Infestation" in that set

    # When I go to the cards page
    # And I add "3" of the "Trigon of Infestation" card to the deck
    # And I go to the deck page
    # Then I should see the table for the deck, which looks like:
    #   | Number | Name                  | Cost | Conv. Cost | Type     | Pow./Tgh. |
    #   | 3      | Trigon of Infestation | 4    | 4          | Artifact |           |



  # Scenario: Removing cards from the deck
  #   Given a set named "SOM"
  #   And the "Trigon of Infestation" card has been added to that set
  #   And "3" of that card has been added to the deck
  #   And I am on the deck page
  #
  #   When I remove "2" of the "Trigon of Infestation" card from the deck
  #   Then I should see the table for the deck, which looks like:
  #     |   |   | Name                  | Cost | Conv. Cost | Type     | Pow./Tgh. |
  #     | 1 | x | Trigon of Infestation | 4    | 4          | Artifact |           |
  #
  #   When I remove "1" of the