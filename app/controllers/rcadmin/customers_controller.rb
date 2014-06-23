class Rcadmin::CustomersController < ApplicationController
  before_filter :check_auth, :authenticate
  before_action :set_rcadmin_customer, only: [:show, :edit, :update, :destroy]

  # GET /rcadmin/customers
  # GET /rcadmin/customers.json
  def index
    session['act'] = nil
    @rcadmin_customers = Rcadmin::Customer.all
  end

  # GET /rcadmin/customers/1
  # GET /rcadmin/customers/1.json
  def show
  end

  # GET /rcadmin/customers/new
  def new
     
    @rcadmin_customer = Rcadmin::Customer.new
    session['act'] = "qcustomer" if params[:contractor_id]
  end

  # GET /rcadmin/customers/1/edit
  def edit
	@quote = Rcadmin::Quote.find_by_customer(params[:id])
  end

  # POST /rcadmin/customers
  # POST /rcadmin/customers.json
  def create
    @rcadmin_customer = Rcadmin::Customer.new(rcadmin_customer_params)
    if params['act'] == "qcustomer"
      session['act'] = "qcustomer"
    end
    respond_to do |format|
      if @rcadmin_customer.save
	if(session['act'] == "qcustomer")
	   @quote = Rcadmin::Quote.new
	   #@quote.admin_id  = current_user.id
	   @quote.contractor_id = @rcadmin_customer.contractor_id
	   @quote.customer_id = @rcadmin_customer.id
	   @quote.save
	   session[:quote_id] = @quote.id
	   format.html { redirect_to select_quote_category_path, notice: 'Customer was successfully created.' }
	else
	  flash[:notice] = 'Customer was successfully created.'
	  format.html { redirect_to rcadmin_customers_url, notice: 'Customer was successfully created.' }
	  format.json { render action: 'show', status: :created, location: @rcadmin_customer }
	end
	
      else
        format.html { render action: 'new' }
        format.json { render json: @rcadmin_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rcadmin/customers/1
  # PATCH/PUT /rcadmin/customers/1.json
  def update
  
    respond_to do |format|
      if @rcadmin_customer.update(rcadmin_customer_params)
      flash[:notice] = 'Customer was successfully updated.'
        format.html { redirect_to rcadmin_customers_url, notice: 'Customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rcadmin_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rcadmin/customers/1
  # DELETE /rcadmin/customers/1.json
  def destroy
    @rcadmin_customer.destroy
    respond_to do |format|
    flash[:notice] = 'Customer was successfully deleted.'
      format.html { redirect_to rcadmin_customers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rcadmin_customer
      @rcadmin_customer = Rcadmin::Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rcadmin_customer_params
      params.require(:rcadmin_customer).permit(:first_name, :last_name,:title,:address, :city, :state, :zip, :email, :phone, :status,:contractor_id)
    end
end
