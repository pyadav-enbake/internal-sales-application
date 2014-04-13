class MiscProductsController < ApplicationController


  def create
    @quote = Rcadmin::Quote.find(params[:quote_id])
    product_type = params[:misc_product][:product_type]
    @misc_product = @quote.send("misc_#{product_type}_products".to_sym).create(params[:misc_product])
  end

  def update
  end

  def destroy
  end
end
