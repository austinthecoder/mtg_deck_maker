Given /^the "([^"]*)" card has been added to that set$/ do |card_name|
  @card = Factory(card_name, :mtg_set => @mtg_set)
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