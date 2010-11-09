class CardsController < ApplicationController

  SQL_ORDERINGS = {
    'Name' => 'cards.name ASC',
    'Type' => 'cards.type_line ASC',
    'Pow.' => 'cards.power ASC',
    'Tgh.' => 'cards.toughness ASC'
  }
  ARRAY_ORDERINGS = {
    'Conv. Cost' => :converted_mana_cost,
    'Rarity' => :rarity
  }

  before_filter :build_card, :only => %w(new create)
  before_filter :find_card, :only => %w(show edit update)

  respond_to :html

  ##################################################

  def index
    @cards = Card.includes(:mtg_set)

    if order_sql = SQL_ORDERINGS[params[:sort]]
      @cards = @cards.order(order_sql)
    elsif sort_attr = ARRAY_ORDERINGS[params[:sort]]
      @cards = @cards.sort_by { |c| c.send(sort_attr) }
    else
      @cards = @cards.order(SQL_ORDERINGS['Name'])
    end

    @cards = @cards.paginate(:page => params[:page], :per_page => 100)
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