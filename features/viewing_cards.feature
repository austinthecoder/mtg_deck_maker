Feature: Viewing cards

  Scenario: Viewing all cards when there are none
    When I go to the cards page
    Then I should see "There are no cards!"
    And I should see "Add a card"



  Scenario: Viewing an individual card
    Given a set
    And a card

    When I go to that card's page
    Then I should see the table for that card