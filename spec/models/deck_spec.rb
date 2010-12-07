require 'spec_helper'

describe Deck do

  describe "instance methods" do
    before { @d = Factory.build(:deck) }

    describe "#add_card!" do
      before do
        @d = Factory(:deck)
        @card = Factory(:card)
      end

      context "when the card has been added already" do
        before { @d.deck_cards.create!(:card => @card, :number => 1) }

        it "increases the number for that card" do
          @d.add_card!(@card, 3)
          @d.reload.deck_cards.find_by_card_id(@card.id).number.should eq(4)
        end
      end

      context "when the card has not been added to the deck" do
        it "adds the card to the deck" do
          @d.add_card!(@card, 3)
          @d.reload.deck_cards.find_by_card_id(@card.id).number.should eq(3)
        end
      end
    end

    describe "#remove_card!" do
      before do
        @d = Factory(:deck)
        @card = Factory(:card)
      end

      context "when 4 of that card exists in the deck" do
        before { @d.deck_cards.create!(:card => @card, :number => 4) }

        [
          [0, 4],
          [3, 1],
        ].each do |number, left|
          context "when removing #{number.inspect}" do
            it "decreases the number to #{left} for that card" do
              @d.remove_card!(@card, number)
              @d.reload.deck_cards.find_by_card_id(@card.id).number.should eq(left)
            end
          end
        end

        [4, 5].each do |number|
          context "when removing #{number.inspect}" do
            it "removes that card completely" do
              @d.remove_card!(@card, number)
              @d.reload.deck_cards.find_by_card_id(@card.id).should be_nil
            end
          end
        end
      end
    end

    describe "#adjust_card!" do
      before do
        @d = Factory(:deck)
        @card = Factory(:card)
      end

      context "when the number is greater than 0" do
        it "adds card to the deck" do
          @d.should_receive(:add_card!).with(@card, 3)
          @d.adjust_card!(@card, 3)
        end
      end

      context "when the number is less than 0" do
        it "adds card to the deck" do
          @d.should_receive(:remove_card!).with(@card, 3)
          @d.adjust_card!(@card, -3)
        end
      end
    end

    describe "#delete_card!" do
      before do
        @d = Factory(:deck)
        @card = Factory(:card)
      end

      context "when a card exists in the deck" do
        before { @d.deck_cards.create!(:card => @card, :number => 1) }

        it "removes that card completely" do
          @d.delete_card!(@card)
          @d.reload.deck_cards.find_by_card_id(@card.id).should be_nil
        end
      end
    end
  end

end