class MiscProductsController < ApplicationController


  def create
    @quote = Rcadmin::Quote.find(params[:quote_id])
    @misc_product = @quote.misc_products.create(params[:misc_product])
  end

  def update
  end

  def destroy
  end
end
