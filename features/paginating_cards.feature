Feature: Paginating cards

  Scenario: When there are less than 101 cards
    Given a set named "SOM"
    And 100 cards have been added to that set

    When I go to the cards page
    Then I should see 100 cards
    And I should not see the cards pagination



  Scenario: When there are more than 100 cards
    Given a set named "SOM"
    And 222 cards have been added to that set

    When I go to the cards page
    Then I should see 100 cards
    And I should see the cards pagination

    When I follow "Next" within the pagination
    Then I should see 100 cards

    When I follow "Next" within the pagination
    Then I should see 22 cards

    When I follow "Previous" within the pagination
    Then I should see 100 cards

    When I follow "Previous" within the pagination
    Then I should see 100 cards