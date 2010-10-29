require 'spec_helper'

describe SetsController do

  describe "GET new" do
    it "builds an mtg_set" do
      controller.should_receive(:build_mtg_set)
      get :new
    end

    it "renders the :new template" do
      get :new
      response.should render_template(:new)
    end
  end

  describe "POST create" do
    before do
      @mtg_set = mock_model(MtgSet, :save => true)
      controller.stub!(:mtg_set => @mtg_set)
    end

    it "builds an mtg_set" do
      controller.should_receive(:build_mtg_set)
      post :create
    end

    it "responds with" do
      controller.stub!(:render => nil)
      controller.should_receive(:respond_with).with(@mtg_set, :location => mtg_sets_url)
      post :create
    end

    context "when the mtg_set saves" do
      before { post :create }

      it("adds notice") { flash[:notice].should == "Set was added, thanks!" }
    end
  end

  ##################################################

  describe "#build_mtg_set" do
    before do
      @mtg_set = mock_model(MtgSet)
      MtgSet.stub!(:new => @mtg_set)
      controller.stub!(:params => {:mtg_set => {:name => 'test'}})
    end

    it "instantiates an mtg_set" do
      MtgSet.should_receive(:new).with({:name => 'test'})
      controller.build_mtg_set
    end

    it "assigns the mtg_set" do
      controller.build_mtg_set
      assigns(:mtg_set).should == @mtg_set
    end
  end

end