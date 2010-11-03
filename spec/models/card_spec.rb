require 'spec_helper'

describe Card do

  before do
    @s = Factory(:mtg_set)
    @c = Factory.build(:card, :mtg_set => @s)
  end

  it("is valid") { @c.should be_valid }

  describe "validations" do
    context "with no set" do
      before { @c.mtg_set = nil }
      it("has 1 error on mtg_set") { @c.should have(1).error_on(:mtg_set) }
    end

    context "with no name" do
      before { @c.name = nil }
      it("has 1 error on name") { @c.should have(1).error_on(:name) }
    end

    context "when a card exists with the same name, in the same set" do
      before { Factory(:card, :name => @c.name, :mtg_set => @s) }
      it("has 1 error on name") { @c.should have(1).error_on(:name) }
    end

    context "when a card exists with the same name, in a different set" do
      before { Factory(:card, :name => @c.name) }
      it("has 0 errors on name") { @c.should have(0).errors_on(:name) }
    end

    context "when the type line is blank" do
      before { @c.type_line = nil }
      it("has 1 errors on type_line") { @c.should have(1).errors_on(:base) }
    end

    # number
    ['', nil].each do |number|
      context "when the number is #{number.inspect}" do
        before { @c.number = number }

        it("is invalid") do
          @c.valid?
          @c.errors.full_messages.should == ["Number can't be blank"]
        end
      end
    end

    context "when the number is 0" do
      before { @c.number = 0 }

      it("is invalid") do
        @c.valid?
        @c.errors.full_messages.should == ["Number is too low"]
      end
    end

    context "when the number is higher than the number of cards in the set" do
      before { @c.number = @c.mtg_set.num_cards + 1 }

      it("is invalid") do
        @c.valid?
        @c.errors.full_messages.should == [
          "Number is too high (the set contains #{@c.mtg_set.num_cards} cards)"
        ]
      end
    end

    context "when a card exists with the same number, in the same set" do
      before { Factory(:card, :number => @c.number, :mtg_set => @s) }

      it("is invalid") do
        @c.valid?
        @c.errors.full_messages.should == [
          "Number has already been taken"
        ]
      end
    end
  end

  Card::COLORS.each do |color|
    [color, "#{color}?"].each do |method|
      describe method do
        [
          [nil, false],
          ['', false],
          [Card::COLORS.join(' '), true],
          [Card::COLORS.select { |c| c != color }.join(' '), false]
        ].each do |colors, bool|
          context "when the colors is #{colors.inspect}" do
            before { @c.colors = colors }

            it("returns #{bool.inspect}") { @c.send(color).should eq(bool) }
          end
        end
      end
    end

    describe "#{color}=" do
      [0, '0', false, nil].each do |value|
        context "when the value is #{value.inspect}" do
          [
            [nil, ''],
            ['', ''],
            [Card::COLORS.join(' '), Card::COLORS.select { |c| c != color }.join(' ')]
          ].each do |colors_before, colors_after|
            context "when the colors is #{colors_before.inspect}" do
              before { @c.colors = colors_before }

              it("sets the colors to #{colors_after.inspect}") do
                @c.send("#{color}=", value)
                @c.colors.should == colors_after
              end
            end
          end
        end
      end

      [1, '1', true].each do |value|
        context "when the value is #{value.inspect}" do
          [
            [nil, color],
            ['', color],
            [Card::COLORS.join(' '), Card::COLORS.join(' ')]
          ].each do |colors_before, colors_after|
            context "when the colors is #{colors_before.inspect}" do
              before { @c.colors = colors_before }

              it("sets the colors to #{colors_after.inspect}") do
                @c.send("#{color}=", value)
                @c.colors.should == colors_after
              end
            end
          end
        end
      end
    end
  end

  describe "#power_and_toughness=" do
    [
      ['3/5', '3', '5'],
      ['2/*', '2', '*'],
      [' */* ', '*', '*']
    ].each do |p_t, p, t|
      context "when #{p_t.inspect}" do
        before { @c.power_and_toughness = p_t }

        it("sets the power to #{p.inspect}") { @c.power.should == p }
        it("sets the toughness to #{t.inspect}") { @c.toughness.should == t }
      end
    end
  end

  describe "power_and_toughness" do
    context "when the power is '3' and the toughness is '5'" do
      before do
        @c.power = '3'
        @c.toughness = '5'
      end

      it("returns '3/5'") { @c.power_and_toughness.should == '3/5' }
    end
  end

  describe "#mana_cost" do
    before do
      @mana_cost = MTG::Card::ManaCost.new(@c.mana_cost)
      MTG::Card::ManaCost.stub!(:new => @mana_cost)
    end

    it "instantiates a mana cost" do
      MTG::Card::ManaCost.should_receive(:new).with(@c.mana_cost)
      @c.mana_cost
    end

    it("returns the mana cost") { @c.mana_cost.should eq(@mana_cost) }
  end

  describe "#rarity" do
    before do
      @rarity = MTG::Card::Rarity.new(@c.rarity)
      MTG::Card::Rarity.stub!(:new => @rarity)
    end

    it "instantiates a rarity" do
      MTG::Card::Rarity.should_receive(:new).with(@c.rarity)
      @c.rarity
    end

    it("returns the rarity") { @c.rarity.should eq(@rarity) }
  end

end
