Factory.sequence :name do |n|
  "Name #{n}"
end



### Sets ###

Factory.define :mtg_set do |m|
  m.name { Factory.next :name }
  m.released_at 1.year.ago
  m.num_cards 150
end

Factory.define :som_set, :class => MtgSet do |m|
  m.name 'Scars of Mirrodin'
  m.released_at Date.parse('2010-10-01')
  m.num_cards 249
end

Factory.define :zen_set, :class => MtgSet do |m|
  m.name 'Zendikar'
  m.released_at Date.parse('2009-10-02')
  m.num_cards 249
end



### Cards ###

Factory.define :card do |m|
  m.association :mtg_set
  m.name { Factory.next :name }
  m.type_line 'Land'
  m.number 50
  m.rarity 'common'
end

[
  {
    :name => "Kemba's Skyguard",
    :mana_cost => '1WW',
    :type_line => "Creature - Cat Knight",
    :number => 13,
    :power => 2,
    :toughness => 2,
    :rules_text => "When Kemba's Skyguard enters the battlefield, you gain 2 life.",
    :white => true,
    :rarity => 'common'
  },
  {
    :name => "Venser, the Sojourner",
    :mana_cost => '3WU',
    :type_line => "Planeswalker - Venser",
    :number => 135,
    :loyalty => 3,
    :rules_text => %|+2: Exile target permanent you own. Return it to the battlefield under your control at the beginning of the next end step.
-1: Creatures are unblockable this turn.
-8: You get an emblem with "Whenever you cast a spell, exile target permanent."|,
    :white => true,
    :blue => true,
    :rarity => 'mythic rare'
  },
  {
    :number => 3,
    :name => 'Auriok Edgewright',
    :white => true,
    :mana_cost => 'WW',
    :type_line => "Creature - Human Soldier",
    :power_and_toughness => '2/2',
    :rarity => 'uncommon',
    :rules_text => "Metalcraft - Auriok Edgewright has double strike as long as you control three or more artifacts."
  },
  {
    :number => 4,
    :name => 'Echo Circlet',
    :mana_cost => '2',
    :type_line => "Artifact - Equipment",
    :rarity => 'common',
    :rules_text => "Equipped creature can block an additional creature. Equip {1}"
  },
  {
    :number => 1,
    :name => 'Abuna Acolyte',
    :mana_cost => '1W',
    :type_line => "Creature - Cat Cleric",
    :white => true,
    :power_and_toughness => '1/1',
    :rarity => 'uncommon',
    :rules_text => "{T}: Prevent the next 1 damage that would be dealt to target creature or player this turn.
{T}: Prevent the next 2 damage that would be dealt to target artifact creature this turn."
  }
].each do |attrs|
  Factory.define attrs[:name], :class => Card do |m|
    m.association :mtg_set
    attrs.each do |k, v|
      m.send(k, v)
    end
  end
end