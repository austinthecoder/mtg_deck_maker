Feature: Sorting Cards

  Scenario: Sorting
    Given a set named "SOM"
    And the following cards in that set:
      | Name                  | Mana Cost | Rarity      | Type                     | Power | Toughness |
      | Trigon of Infestation | 4         | uncommon    | Artifact                 |       |           |
      | Echo Circlet          | 2         | common      | Artifact - Equipment     |       |           |
      | Auriok Edgewright     | WW        | mythic rare | Creature - Human Soldier | 2     | 2         |
      | Abuna Acolyte         | 1W        | uncommon    | Creature - Cat Cleric    | 1     | 1         |
      | Sunblast Angel        | 4WW       | rare        | Creature - Angel         | 4     | 5         |
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
      | C  |
      | U  |
      | U  |
      | R  |
      | MR |

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