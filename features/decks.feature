Feature: Decks

  Scenario: Homepage redirect
    When I go to the home page
    Then I should be on the new deck page



  Scenario: Adding cards to deck
    Given the "SOM" set has been added
    And the SOM cards have been added