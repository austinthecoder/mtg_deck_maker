Given /^the "([^"]*)" card has been added$/ do |name|
  factory_name = {
    'Venser, the Sojourner' => :venser_the_sojourner,
    "Kemba's Skyguard" => :kembas_skyguard
  }[name]
  @card = Factory(factory_name, :mtg_set => @mtg_set)
end

##################################################

Then /^I should see the table for that card, which looks like:$/ do |table|
  table.diff! tableish("table#card_#{@card.id} tr", 'th, td')
end