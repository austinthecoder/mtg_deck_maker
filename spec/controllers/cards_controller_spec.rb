require 'spec_helper'

describe CardsController do

  describe "#build_card" do
    before do
      @card = mock_model(Card)
      Card.stub!(:new => @card)
      controller.stub!(:params => {:card => {:name => 'test'}})
    end

    it "instantiates a card" do
      Card.should_receive(:new).with({:name => 'test'})
      controller.build_card
    end

    it "assigns the card" do
      controller.build_card
      assigns(:card).should == @card
    end
  end

  describe "#find_card" do
    context "when a card exists matching the id in the params" do
      before do
        @card = Factory(:card)
        controller.stub!(:params => {:id => @card.id})
      end

      it "assigns the card" do
        controller.find_card
        assigns(:card).should == @card
      end
    end
  end

end