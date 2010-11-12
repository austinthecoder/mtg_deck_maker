Given /^the "([^"]*)" card has been added to that set$/ do |card_name|
  @card = Factory(card_name, :mtg_set => @mtg_set)
end

Given /^(\d+) cards have been added to that set$/ do |num_cards|
  num_cards.to_i.times do |i|
    Factory(:card, :mtg_set => @mtg_set, :number => (i + 1))
  end
end

Given /^the following cards have been added to that set:$/ do |table|
  table.raw.each do |row|
    Given %|the "#{row[0]}" card has been added to that set|
  end
end

##################################################

When /^I follow "([^"]*)" within the card's table header$/ do |link|
  When %|I follow "#{link}" within "#cards tr"|
end

When /^I sort the cards by "([^"]*)"$/ do |header|
  with_scope("#cards thead tr") do
    click_link(header)
  end
end

When /^I follow "([^"]*)" within the pagination$/ do |link|
  with_scope('.pagination') { click_link(link) }
end

When /^I add "([^"]*)" of the "([^"]*)" card to the deck$/ do |num, card_name|
  card = Card.find_by_name(card_name)
  with_scope('#cards') do
    with_scope("#card_#{@card.id}") do
      fill_in("number", :with => num)
      click_button("add")
    end
  end
end

Then /^I should see the table for the deck, which looks like:$/ do |table|
  table.raw.should == tableish("table#deck tr", 'th, td').to_a
  # table.diff! tableish("table#deck tr", 'th, td')
end

##################################################

Then /^I should see the table for that card, which looks like:$/ do |table|
  table.diff! tableish("table#card_#{@card.id} tr", 'th, td')
end

Then /^the "([^"]*)" column should look like:$/ do |header, table|
  cell_class = {
    'Name' => 'name',
    'Conv. Cost' => 'conv_mana_cost',
    'Rarity' => 'rarity',
    'Type' => 'type',
    'Pow.' => 'power',
    'Tgh.' => 'toughness'
  }[header]

  with_scope "#cards" do
    all("tbody td.#{cell_class}").map(&:text).should == table.raw.flatten
  end
end

Then /^I should see (\d+) cards$/ do |num_cards|
  all('#cards tbody tr').size.should == num_cards.to_i
end

Then /^I should not see the cards pagination$/ do
  Then %|I should not see ".pagination"|
end

Then /^I should see the cards pagination$/ do
  Then %|I should see "Next" within ".pagination"|
end