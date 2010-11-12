require 'spec_helper'

describe DeckCard do

  before { @dc = Factory.build(:deck_card) }

  it("is valid") { @dc.should be_valid }

  describe "validations" do
    context "with no deck" do
      before { @dc.deck = nil }

      it("is invalid") do
        @dc.should be_invalid
        @dc.errors.full_messages.should == ["Deck can't be blank"]
      end
    end

    context "with no card" do
      before { @dc.card = nil }

      it("is invalid") do
        @dc.should be_invalid
        @dc.errors.full_messages.should == ["Card can't be blank"]
      end
    end

    context "when a card already exists in the same deck" do
      before { Factory(:deck_card, :deck => @dc.deck, :card => @dc.card) }

      it("is invalid") do
        @dc.should be_invalid
        @dc.errors.full_messages.should == ["Card has already been taken"]
      end
    end
  end

end