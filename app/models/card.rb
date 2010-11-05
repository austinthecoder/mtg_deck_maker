class Card < ActiveRecord::Base

  RARITIES = %w(common uncommon rare mythic\ rare)
  COLORS = %w(red black blue white green)
  COLOR_SEPARATOR = ' '

  # associations
  belongs_to :mtg_set

  # validations
  validates :name, :presence => true, :uniqueness => {:scope => :mtg_set_id}

  validates :mtg_set, :presence => true

  validate :mana_cost do
    errors.add(:mana_cost, 'has invalid format') unless mana_cost.is_a?(MTG::Card::ManaCost)
  end

  validate :rarity do
    errors.add(:rarity, 'has invalid format') unless rarity.is_a?(MTG::Card::Rarity)
  end

  validates :number, :presence => true, :uniqueness => {:scope => :mtg_set_id}
  validate :number do
    return if number.blank?
    if number < 1
      errors.add(:number, "is too low")
    elsif mtg_set && number > mtg_set.num_cards
      errors.add(:number, "is too high (the set contains #{mtg_set.num_cards} cards)")
    end
  end

  validate :type_line do
    errors.add(:base, "Type can't be blank") if type_line.blank?
  end

  ##################################################

  COLORS.each do |color|
    define_method(color) { has_color?(color) }

    alias_method "#{color}?", color

    define_method("#{color}=") do |value|
      case value
      when 0, '0', false, nil
        remove_color(color)
      when 1, '1', true
        add_color(color)
      end
    end
  end

  def power_and_toughness=(value)
    self.power, self.toughness = value.to_s.split('/').map(&:strip)
  end

  def power_and_toughness
    [power, toughness].join('/') unless [power, toughness].any?(&:blank?)
  end

  def colors_array
    self[:colors].to_s.split(COLOR_SEPARATOR)
  end

  def mana_cost
    MTG::Card::ManaCost.new(self[:mana_cost])
  rescue ArgumentError
    self[:mana_cost]
  end

  def rarity
    MTG::Card::Rarity.new(self[:rarity])
  rescue ArgumentError
    self[:rarity]
  end

  # TODO: test
  def rules_text_html
    rules_text ? rules_text.gsub(/\n/, '<br />') : ''
  end

  ##################################################
  private

  def add_color(color)
    self[:colors] = colors_array.push(color).uniq.join(COLOR_SEPARATOR)
  end

  def remove_color(color)
    array = colors_array
    array.delete(color)
    self[:colors] = array.join(COLOR_SEPARATOR)
  end

  def has_color?(color)
    colors_array.include?(color)
  end

end
