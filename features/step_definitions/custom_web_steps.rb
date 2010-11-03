When /^I fill in "([^"]*)" with:$/ do |field, value|
  fill_in(field, :with => value)
end

##################################################

Then /^I should see the sets table, which looks like:$/ do |table|
  table.diff! tableish('#mtg_sets tr', 'th, td')
end