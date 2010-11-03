Factory.sequence :name do |n|
  "Name #{n}"
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
  m.number 50
  m.rarity 'common'
end