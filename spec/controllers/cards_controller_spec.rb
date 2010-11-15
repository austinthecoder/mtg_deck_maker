require 'spec_helper'

describe CardsController do

  describe "collection actions" do
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

  describe "member actions" do
    before do
      @card = Factory(:card)
      @params = ActiveSupport::HashWithIndifferentAccess.new({:id => @card.id})
    end

    describe "GET show" do
      it("finds the card") do
        controller.should_receive(:find_card)
        get :show, @params
      end

      it "renders the :show template" do
        get :show, @params
        response.should render_template(:show)
      end
    end

    describe "GET edit" do
      it("finds the card") do
        controller.should_receive(:find_card)
        get :edit, @params
      end

      it "renders the :edit template" do
        get :edit, @params
        response.should render_template(:edit)
      end
    end

    describe "PUT update" do
      before do
        controller.stub!(:card => @card)
        @params[:card] = {:name => 'some name'}
      end

      it "finds the card" do
        controller.should_receive(:find_card)
        put :update, @params
      end

      it "updates the cards attributes" do
        @card.should_receive(:update_attributes).with(@params[:card])
        put :update, @params
      end

      context "when the updating the attributes succeeds" do
        it("adds notice") do
          put :update, @params
          flash[:notice].should == "Card was updated, thanks!"
        end
      end

      it "responds with" do
        controller.stub!(:render => nil)
        controller.should_receive(:respond_with).with(@card, :location => cards_url)
        put :update, @params
      end
    end

    describe "GET add_to_deck" do
      before do
        @d = Factory(:deck)
        @d.stub!(:add_card! => nil)
        controller.stub!(:current_deck => @d)
      end

      it "finds the card" do
        controller.stub!(:card => @card)
        controller.should_receive(:find_card)
        get :add_to_deck, @params
      end

      [
        [nil, 1],
        ['', 1],
        ['a', 1],
        ['0', 1],
        ['2', 2]
      ].each do |params_number, number|
        context "when the number is #{params_number.inspect}" do
          before { @params[:number] = params_number }

          it do
            @d.should_receive(:add_card!).with(@card, number)
            get :add_to_deck, @params
          end
        end
      end

      it "redirects to the deck page" do
        get :add_to_deck, @params
        response.should redirect_to(deck_url)
      end
    end

    describe "GET remove_from_deck" do
      before do
        @d = Factory(:deck)
        @d.stub!(:remove_card! => nil)
        controller.stub!(:current_deck => @d)
        controller.stub!(:card => @card)
      end

      it "finds the card" do
        controller.should_receive(:find_card)
        get :remove_from_deck, @params
      end

      [
        [nil, 1],
        ['', 1],
        ['a', 1],
        ['0', 1],
        ['2', 2]
      ].each do |params_number, number|
        context "when the number is #{params_number.inspect}" do
          before { @params[:number] = params_number }

          it do
            @d.should_receive(:remove_card!).with(@card, number)
            get :remove_from_deck, @params
          end
        end
      end

      # it "redirects to the deck page" do
      #   get :add_to_deck, @params
      #   response.should redirect_to(deck_url)
      # end
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