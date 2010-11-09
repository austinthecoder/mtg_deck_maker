Feature: Sorting Cards

  Scenario: Sorting
    Given the "SOM" set has been added
    And the "Trigon of Infestation" card has been added to that set
    And the "Echo Circlet" card has been added to that set
    And the "Auriok Edgewright" card has been added to that set
    And the "Abuna Acolyte" card has been added to that set
    And the "Sunblast Angel" card has been added to that set
    And I am on the cards page

    When I sort the cards by "Name"
    Then the "Name" column should look like:
      | Abuna Acolyte         |
      | Auriok Edgewright     |
      | Echo Circlet          |
      | Sunblast Angel        |
      | Trigon of Infestation |

    When I sort the cards by "Conv. Cost"
    Then the "Conv. Cost" column should look like:
      | 2 |
      | 2 |
      | 2 |
      | 4 |
      | 6 |

    When I sort the cards by "Rarity"
    Then the "Rarity" column should look like:
      | C |
      | U |
      | U |
      | U |
      | R |

    When I sort the cards by "Type"
    Then the "Type" column should look like:
      | Artifact                 |
      | Artifact - Equipment     |
      | Creature - Angel         |
      | Creature - Cat Cleric    |
      | Creature - Human Soldier |

    When I sort the cards by "Pow."
    Then the "Pow." column should look like:
      | 1 |
      | 2 |
      | 4 |
      |   |
      |   |

    When I sort the cards by "Tgh."
    Then the "Tgh." column should look like:
      | 1 |
      | 2 |
      | 5 |
      |   |
      |   |