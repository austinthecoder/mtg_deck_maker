Given /^a card in (that set)$/ do |set|
  Factory(:card, :mtg_set => set)
end

Given /^a card named "([^"]*)" in (that set)$/ do |name, set|
  Factory(:card, :name => name, :mtg_set => set)
end

Given /^a card in (that set) with the attributes:$/ do |set, table|
  attrs = {:mtg_set => set}
  table.rows_hash.each do |k, v|
    key = case k
    when 'Type'
      :type_line
    else
      k.downcase.gsub(' ', '_').to_sym
    end
    attrs[key] = v
  end
  Factory(:card, attrs)
end

Given /^the following cards in (that set):$/ do |set, table|
  table.map_headers!(
    'Name' => :name,
    'Mana Cost' => :mana_cost,
    'Rarity' => :rarity,
    'Type' => :type_line,
    'Power' => :power,
    'Toughness' => :toughness
  )
  table.hashes.each do |attrs|
    Factory(:card, attrs.merge(:mtg_set => set))
  end
end

Given /^(\d+) cards have been added to (that set)$/ do |num_cards, set|
  num_cards.to_i.times { |i| Factory(:card, :mtg_set => set, :number => (i + 1)) }
end

##################################################

When /^I sort the cards by "([^"]*)"$/ do |header|
  with_scope("#cards thead tr") do
    click_link(header)
  end
end

When /^I follow "([^"]*)" within the pagination$/ do |link|
  with_scope('.pagination') { click_link(link) }
end

##################################################

Then /^I should see (\d+) cards$/ do |num_cards|
  all('#cards tbody tr').size.should == num_cards.to_i
end

Then /^I should not see the cards pagination$/ do
  Then %|I should not see ".pagination"|
end

Then /^I should see the cards pagination$/ do
  Then %|I should see "Next" within ".pagination"|
end

Then /^I should see (that card)'s table, i.e.:$/ do |card, table|
  table.diff! tableish("table#card_#{card.id} tr", 'th, td')
end

Then /^the "([^"]*)" column should look like:$/ do |header, table|
  css_class = {
    'Name' => 'name',
    'Conv. Cost' => 'conv_mana_cost',
    'Rarity' => 'rarity',
    'Type' => 'type',
    'Pow.' => 'power',
    'Tgh.' => 'toughness'
  }[header]
  tableish("table#cards", "td.#{css_class}").flatten.map { |c| [c] }.should eq(table.raw)
end