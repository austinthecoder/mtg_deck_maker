Feature: Sorting Cards

  Scenario: Sorting
    Given the "SOM" set has been added
    And the "Auriok Edgewright" card has been added to that set
    And the "Echo Circlet" card has been added to that set
    And the "Abuna Acolyte" card has been added to that set
    And I am on the cards page

    When I sort the cards by "Name"
    Then the "Name" column should look like:
      | Abuna Acolyte     |
      | Auriok Edgewright |
      | Echo Circlet      |

    When I sort the cards by "Cost"
    Then the "Cost" column should look like:
      | 2  |
      | 1W |
      | WW |

    #
    # When I follow "Conv. Cost" within the card's table header
    # Then the cards should be sorted by "Conv. Cost"
    #
    # When I follow "Rarity" within the card's table header
    # Then the cards should be sorted by "Rarity"
    #
    # When I follow "Type" within the card's table header
    # Then the cards should be sorted by "Type"
    #
    # When I follow "Rules Text" within the card's table header
    # Then the cards should be sorted by "Rules Text"
    #
    # When I follow "Pow." within the card's table header
    # Then the cards should be sorted by "Pow."
    #
    # When I follow "Tgh." within the card's table header
    # Then the cards should be sorted by "Tgh."