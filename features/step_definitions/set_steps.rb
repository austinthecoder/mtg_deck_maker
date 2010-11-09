Given /^the "([^"]*)" set has been added$/ do |name|
  @mtg_set = case name
  when 'SOM'
    Factory(:som_set)
  when 'ZEN'
    Factory(:zen_set)
  end
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