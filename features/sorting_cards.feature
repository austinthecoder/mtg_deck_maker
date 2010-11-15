Feature: Sorting Cards

  Scenario: Sorting
    Given a set named "SOM"
    And the following cards have been added to that set:
      | Trigon of Infestation |
      | Echo Circlet          |
      | Auriok Edgewright     |
      | Abuna Acolyte         |
      | Sunblast Angel        |
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