Given /^the SOM set has been added$/ do
  steps %Q{
    When I go to the new set page
    And I fill in the following:
      | Name            | Scars of Mirrodin |
      | Number of cards | 249               |
    And I select "2010" from "mtg_set_released_at_1i"
    And I select "October" from "mtg_set_released_at_2i"
    And I select "1" from "mtg_set_released_at_3i"
    And I press "Add this set"
  }
  @mtg_set = MtgSet.find_by_name('Scars of Mirrodin')
end

Given /^the ZEN set has been added$/ do
  steps %Q{
    When I go to the new set page
    And I fill in the following:
      | Name            | Zendikar |
      | Number of cards | 249      |
    And I select "2009" from "mtg_set_released_at_1i"
    And I select "October" from "mtg_set_released_at_2i"
    And I select "2" from "mtg_set_released_at_3i"
    And I press "Add this set"
  }
end

##################################################

When /^I follow "([^"]*)" for that set$/ do |link|
  with_scope("#mtg_sets #mtg_set_#{@mtg_set.id}") do
    click_link(link)
  end
end