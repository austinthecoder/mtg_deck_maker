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

Factory.define :kembas_skyguard, :class => Card do |m|
  m.association :mtg_set
  m.name "Kemba's Skyguard"
  m.mana_cost '1WW'
  m.type_line "Creature - Cat Knight"
  m.number 13
  m.power 2
  m.toughness 2
  m.rules_text "When Kemba's Skyguard enters the battlefield, you gain 2 life."
  m.white true
  m.rarity 'common'
end

Factory.define :venser_the_sojourner, :class => Card do |m|
  m.association :mtg_set
  m.name "Venser, the Sojourner"
  m.mana_cost '3WU'
  m.type_line "Planeswalker - Venser"
  m.number 135
  m.loyalty 3
  m.rules_text <<-eos
+2: Exile target permanent you own. Return it to the battlefield under your control at the beginning of the next end step.
-1: Creatures are unblockable this turn.
-8: You get an emblem with "Whenever you cast a spell, exile target permanent."
  eos
  m.white true
  m.blue true
  m.rarity 'mythic rare'
end