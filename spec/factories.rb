Factory.sequence :name do |n|
  "Name #{n}"
end

Factory.sequence :card_number do |n|
  (n % 150) + 1
end

##################################################

Factory.define :deck do |m|

end

Factory.define :deck_card do |m|
  m.association :deck
  m.association :card
end

Factory.define :mtg_set do |m|
  m.name { Factory.next :name }
  m.released_at 1.year.ago
  m.num_cards 150
end

Factory.define :card do |m|
  m.association :mtg_set
  m.name { Factory.next :name }
  m.type_line 'Land'
  m.number { Factory.next :card_number }
  m.rarity 'common'
end