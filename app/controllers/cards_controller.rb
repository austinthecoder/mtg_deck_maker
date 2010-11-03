class CardsController < ApplicationController

  before_filter :build_card, :only => %w(new create)

  respond_to :html

  ##################################################

  def index
    @cards = Card.includes(:mtg_set).order('mana_cost ASC')
  end

  def create
    flash[:notice] = "Card was added, thanks!" if card.save
    respond_with(card, :location => cards_url)
  end

  ##################################################

  attr_reader :card

  def build_card
    @card = Card.new(params[:card])
  end

end