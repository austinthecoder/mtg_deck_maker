Feature: Adding Cards

  Scenario: Trying to add a card when no sets exist
    When I go to the new card page
    Then I should see "There are no sets!"
    And I should see "Cards belong to sets and none have been added yet."
    And I should see "Add a set"



  Scenario: Adding a valid card
    Given a set named "Scars of Mirrodin"

    When I go to the new card page
    And I fill in the following:
      | Name      | Venser, the Sojourner |
      | Mana cost | 3WU                   |
      | Type      | Planeswalker — Venser |
      | Number    | 135                   |
      | Loyalty   | 3                     |
    And I fill in "Rules text" with:
      """
      +2: Exile target permanent you own. Return it to the battlefield under your control at the beginning of the next end step.
      -1: Creatures are unblockable this turn.
      -8: You get an emblem with "Whenever you cast a spell, exile target permanent."
      """
    And I check "White"
    And I check "Blue"
    And I select "Mythic Rare" from "Rarity"
    And I select "Scars of Mirrodin" from "Set"
    And I press "Add this card"
    Then I should see "Card was added, thanks!"



  Scenario: Adding an invalid card
    Given a set with 100 cards

    When I go to the new card page
    And I press "Add this card"
    Then I should see "Name can't be blank"
    And I should see "Type can't be blank"
    And I should see "Number can't be blank"

    When I fill in the following:
      | Number    | 500    |
      | Mana cost | IUHKJN |
    And I press "Add this card"
    Then I should see "Mana cost has invalid format"
    Then I should see "Number is too high (the set contains 100 cards)"