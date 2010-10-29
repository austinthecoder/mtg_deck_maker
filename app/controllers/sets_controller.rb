class SetsController < ApplicationController

  before_filter :build_mtg_set, :only => %w(new create)

  respond_to :html

  ##################################################

  def create
    flash[:notice] = "Set was added, thanks!" if mtg_set.save
    respond_with(mtg_set, :location => mtg_sets_url)
  end

  ##################################################

  attr_reader :mtg_set

  def build_mtg_set
    @mtg_set = MtgSet.new(params[:mtg_set])
  end

end