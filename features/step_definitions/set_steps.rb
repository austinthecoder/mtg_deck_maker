Given /^a set$/ do
  Factory(:mtg_set)
end

Given /^a set named "([^"]*)"$/ do |name|
  Factory(:mtg_set, :name => name)
end

Given /^a set with (\d+) cards$/ do |num_cards|
  Factory(:mtg_set, :num_cards => num_cards)
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