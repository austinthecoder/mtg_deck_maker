Given /^a set$/ do
  Factory(:mtg_set)
end

Given /^a set named "([^"]*)"$/ do |name|
  Factory(:mtg_set, :name => name)
end

Given /^a set with (\d+) cards$/ do |num_cards|
  Factory(:mtg_set, :num_cards => num_cards)
end

Given /^the following sets:$/ do |table|
  table.map_headers!('Name' => :name, 'Date Released' => :released_at)
  table.hashes.each { |attrs| Factory(:mtg_set, attrs) }
end

Given /^a set with the attributes:$/ do |table|
  attrs = {}
  table.rows_hash.each do |k, v|
    attrs[k.downcase.gsub(' ', '_').to_sym] = v
  end
  Factory(:mtg_set, attrs)
end

##################################################



##################################################

Then /^I should see the sets table, i\.e\.:$/ do |table|
  table.diff! tableish('#mtg_sets tr', 'th, td')
end