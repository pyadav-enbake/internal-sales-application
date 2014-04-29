class Rcadmin::DashboardController < ApplicationController
  before_filter :check_auth, :authenticate
  def index
    @recent_quotes = current_user.quotes.includes([:contractor, :customer]).last(5)
  end
end
