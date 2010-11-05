class CardsController < ApplicationController

  before_filter :build_card, :only => %w(new create)
  before_filter :find_card, :only => %w(show edit update)

  respond_to :html

  ##################################################

  def index
    @cards = Card.includes(:mtg_set).order('name ASC')
  end

  def create
    flash[:notice] = "Card was added, thanks!" if card.save
    respond_with(card, :location => cards_url)
  end

  ##################################################

  def show
  end

  def edit
  end

  def update
    flash[:notice] = "Card was updated, thanks!" if card.update_attributes(params[:card])
    respond_with(card, :location => cards_url)
  end

  ##################################################

  attr_reader :card

  def build_card
    @card = Card.new(params[:card])
  end

  def find_card
    @card = Card.find(params[:id])
  end

end