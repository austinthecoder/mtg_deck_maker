class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :set_current_deck

  attr_reader :current_deck

  private

  def set_current_deck
    if session[:current_deck_id]
      @current_deck = Deck.find(session[:current_deck_id])
    else
      @current_deck = Deck.create!
      session[:current_deck_id] = @current_deck.id
    end
  end

end
