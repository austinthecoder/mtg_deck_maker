require 'spec_helper'

describe CardsController, "member actions" do

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

  describe "GET adjust_in_deck" do
    before do
      @d = Factory(:deck)
      @d.stub!(:adjust_card! => nil)
      controller.stub!(:current_deck => @d)
      controller.stub!(:card => @card)
    end

    it "finds the card" do
      controller.should_receive(:find_card)
      get :adjust_in_deck, @params
    end

    [
      [nil, 0],
      ['', 0],
      ['a', 0],
      ['0', 0],
      ['2', 2],
      ['-3', -3]
    ].each do |params_number, number|
      context "when the number is #{params_number.inspect}" do
        before { @params[:number] = params_number }

        it do
          @d.should_receive(:adjust_card!).with(@card, number)
          get :adjust_in_deck, @params
        end
      end
    end

    context "when the format is html" do
      it "redirects to the deck page" do
        get :adjust_in_deck, @params
        response.should redirect_to(deck_url)
      end
    end

    context "when the format is json" do
      before { @params.merge!(:format => 'json') }

      it "response is success" do
        get :adjust_in_deck, @params
        response.should be_success
      end
    end
  end

  describe "GET remove_all_from_deck" do
    before do
      @d = Factory(:deck)
      @d.stub!(:delete_card! => nil)
      controller.stub!(:current_deck => @d)
      controller.stub!(:card => @card)
    end

    it "finds the card" do
      controller.should_receive(:find_card)
      get :remove_all_from_deck, @params
    end

    it "deletes the card from the deck" do
      @d.should_receive(:delete_card!).with(@card)
      get :remove_all_from_deck, @params
    end

    context "when the format is html" do
      it "redirects to the deck page" do
        get :remove_all_from_deck, @params
        response.should redirect_to(deck_url)
      end
    end

    context "when the format is json" do
      before { @params.merge!(:format => 'json') }

      it "response is success" do
        get :remove_all_from_deck, @params
        response.should be_success
      end
    end
  end

end