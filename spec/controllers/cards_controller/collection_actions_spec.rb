require 'spec_helper'

describe CardsController, "collection actions" do

  describe "GET index" do
    before do
      @params = {}
      @rel = Card.includes(:mtg_set)
      @rel2 = @rel.order('name ASC')
      @rel.stub!(:order => @rel2)
      Card.stub!(:includes => @rel)
    end

    it "Card receives includes" do
      Card.should_receive(:includes).with(:mtg_set)
      get :index, @params
    end

    [
      [nil, 'cards.name ASC'],
      ['', 'cards.name ASC'],
      ['FooBar', 'cards.name ASC'],
      ['Name', 'cards.name ASC'],
      ['Type', 'cards.type_line ASC'],
      ['Pow.', 'cards.power ASC'],
      ['Tgh.', 'cards.toughness ASC']
    ].each do |sort_param, order|
      context "when the sort param is #{sort_param.inspect}" do
        before { @params[:sort] = sort_param }

        it "relation receives order" do
          @rel.should_receive(:order).with(order)
          get :index, @params
        end
      end
    end

    it "assigns the cards" do
      get :index, @params
      assigns(:cards).should == @rel2
    end
  end

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

end