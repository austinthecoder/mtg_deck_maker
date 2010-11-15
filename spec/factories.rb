Factory.sequence :name do |n|
  "Name #{n}"
end



### Decks ###

Factory.define :deck do |m|

end



### Deck Cards ###

Factory.define :deck_card do |m|
  m.association :deck
  m.association :card
end



### Sets ###

Factory.define :mtg_set do |m|
  m.name { Factory.next :name }
  m.released_at 1.year.ago
  m.num_cards 150
end

# Factory.define :som_set, :class => MtgSet do |m|
#   m.name 'Scars of Mirrodin'
#   m.released_at Date.parse('2010-10-01')
#   m.num_cards 249
# end
#
# Factory.define :zen_set, :class => MtgSet do |m|
#   m.name 'Zendikar'
#   m.released_at Date.parse('2009-10-02')
#   m.num_cards 249
# end



### Cards ###

Factory.define :card do |m|
  m.association :mtg_set
  m.name { Factory.next :name }
  m.type_line 'Land'
  m.number 50
  m.rarity 'common'
end

# [
#
# ].each do |attrs|
#   Factory.define attrs[:name], :class => Card do |m|
#     m.association :mtg_set
#     attrs.each do |k, v|
#       m.send(k, v)
#     end
#   end
# end