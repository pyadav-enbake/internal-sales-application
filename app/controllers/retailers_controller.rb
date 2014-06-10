class RetailersController < ApplicationController

  before_action :find_quote
  
  def new
    @retailer = @quote.build_retailer
  end

  def create
    @retailer = @quote.build_retailer(params[:retailer])
    if @retailer.save
      redirect_to select_quote_category_path
    else
      render :new
    end
  end


  private

  def find_quote
    @quote = current_user.quotes.find(params[:quote_id] || session[:quote_id])
  end
end
