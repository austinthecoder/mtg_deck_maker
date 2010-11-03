require 'spec_helper'

describe CardsController do

  describe "GET new" do
    it "builds a card" do
      controller.should_receive(:build_card)
      get :new
    end

    it "renders the :new template" do
      get :new
      response.should render_template(:new)
    end
  end

  describe "POST create" do
    before do
      @card = mock_model(Card, :save => true)
      controller.stub!(:card => @card)
    end

    it "builds a card" do
      controller.should_receive(:build_card)
      post :create
    end

    it "responds with" do
      controller.stub!(:render => nil)
      controller.should_receive(:respond_with).with(@card, :location => cards_url)
      post :create
    end

    context "when the card saves" do
      before { post :create }

      it("adds notice") { flash[:notice].should == "Card was added, thanks!" }
    end
  end

  ##################################################

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

end