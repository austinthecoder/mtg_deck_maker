Given /^the "([^"]*)" set has been added$/ do |name|
  @mtg_set = case name
  when 'SOM'
    MtgSet.create!(
      :name => 'Scars of Mirrodin',
      :num_cards => 249,
      :released_at => Date.parse('2010-10-01')
    )
  end
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

##################################################

Then /^I should see the sets table, which looks like:$/ do |table|
  table.diff! tableish('#mtg_sets tr', 'th, td')
end