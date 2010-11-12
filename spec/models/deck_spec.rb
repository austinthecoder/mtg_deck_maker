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
  end

end