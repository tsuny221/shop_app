class MarketController < ApplicationController
  def index

	@goods = Good.select_shop
	
	respond_to do |format|
 		format.html
		format.json { render :xml => @good }
	end
  end

end