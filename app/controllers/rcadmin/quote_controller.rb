class Rcadmin::QuoteController < ApplicationController

  protect_from_forgery except: :get_customer
  before_action :check_auth,:authenticate
  def index
	  @rcadmin_customer = Rcadmin::Customer.new
	  session[:quote_id] = nil
	  @quote = Rcadmin::Quote.new
  end

  def save_customer_deatils

    @quote = Rcadmin::Quote.new( params[:rcadmin_quote])
    @quote.customer_id = params[:rcadmin_quote][:customer_id]
    if @quote.save
		    session[:quote_id] = @quote.id
		    redirect_to :action => 'show_category'
    else
	    render :action=> 'index'
    end
  end
  def show_category
    if session[:quote_id] != nil
      @quote = Rcadmin::Quote.find(session[:quote_id] )
      @selected_category = @quote.category.split(',') if !@quote.category.nil?
    else
      @selected_category = []
    end

  end

  def save_category_deatils
    #render :text => params.inspect and return false
    params["quote"]["category"].reject!{|a| a==""} 
    if params[:quote][:category].nil? or params["quote"]["category"].blank?
      flash[:error] = 'Please select any category'
      render :action => 'show_category'
    else
      @quote = Rcadmin::Quote.find(session[:quote_id] )
      params[:quote][:category] = params[:quote][:category].join(',')
      @quote.category = params[:quote][:category]
      if @quote.save
        #redirect_to :action => 'show_product'
        redirect_to :action => 'show_cabinet_selection'
      end
    end		
  end

  def show_product
    if params[:qid]
      @quote_id=params[:qid]
      @customer_id = params[:cid]
      session[:quote_id] = params[:qid]
      @exist_quota_total_price = Rcadmin::QuoteProduct.where(quote_id: params[:qid]).sum(:total_price).to_f.round(2)
      @exist_quota_product_ids = Rcadmin::QuoteProduct.where(quote_id: params[:qid]).pluck(:product_id)
     
    end
    @quote = Rcadmin::Quote.find(session[:quote_id] )
    #@extra_quote_categories = Rcadmin::ExtraCategory.where(quote_id: session[:quote_id] )
    @search_term = (params[:search] != "") ? params[:search] : ''
    @categories =  @quote.categories
    @products =  Rcadmin::Product.all
    @subcategories =  Rcadmin::Subcategory.all

  end

  def send_quote
  #render :text =>  params.inspect and return false
    if params[:product].size > 0
      @quote = Rcadmin::Quote.find(session[:quote_id] )
      @quote.delivery_date = params["extra_info"]['delivery_date']
      @quote.sales_closing_potential = params["extra_info"]['sales_closing_potential']
      @quote.notes = params["extra_info"]['notes']
      @quote.status = 0
      @quote.save
      params[:product].each do |k,v|
        @catid=k 
        v.each do |key,val|
          @quota_product = {}
          @quota_product['quote_id'] = session[:quote_id]
          @quota_product['product_id'] = key.to_i
          @quota_product['quantity'] = params['quantity'][k][key]
          @quota_product['total_price'] = params['tot_price'][k][key]
          @quota_product['status'] = 0
          @quota_product['category_id'] = @catid.to_i
          
          @quota_product['header_option'] = params['header_option'][k][key] if params['header_option'][k]
          @quota_product['header_option'] = 'No' if @quota_product['header_option'] == nil
          #render :text =>  @quota_product.inspect and return false
          if @quota_product['quantity'].to_i > 0
            @rcadmin_quota_product = Rcadmin::QuoteProduct.new(@quota_product) 
            @rcadmin_quota_product.save if params['quantity'][k][key] 
          end
        end
      end
      @customer = Rcadmin::Customer.find(@quote.customer_id)
      WelcomeMailer.send_quote_mail(@quote.customer_id,@quote.id).deliver
      WelcomeMailer.send_quote_mail_customer(@customer,@quote.id).deliver
    end
    render :text => 'ok'
  end

  def resend_quote
    @qid = params["quote_id"]
    @existquote = Rcadmin::Quote.find(@qid)
    @quote = Rcadmin::Quote.copy_quote(@existquote,params["customer_id"])
    
    if @quote.save
      @quote.update_attributes(:delivery_date => params["extra_info"]['delivery_date'],:sales_closing_potential =>  params["extra_info"]['sales_closing_potential'],:notes => params["extra_info"]['notes'] )
      params[:product].each do |k,v|
      	@catid=k 
      	v.each do |key,val|
      	  @quota_product = {}
      	  @quota_product['quote_id'] = @quote.id
      	  @quota_product['product_id'] = key.to_i
      	  @quota_product['quantity'] = params['quantity'][k][key]
      	  @quota_product['total_price'] = params['tot_price'][k][key]
      	  @quota_product['status'] = 0
      	  @quota_product['category_id'] = @catid.to_i
          @quota_product['header_option'] = params['header_option'][k][key] if params['header_option'][k]
          @quota_product['header_option'] = 'No' if @quota_product['header_option'] == nil
      	 # render :text =>  @quota_product.inspect and return false
      	  if @quota_product['quantity'].to_i > 0
      	    @rcadmin_quota_product = Rcadmin::QuoteProduct.new(@quota_product) 
      	    @rcadmin_quota_product.save if params['quantity'][k][key] 
      	  end
      	end
      end
      @customer = Rcadmin::Customer.find(@quote.customer_id)
      WelcomeMailer.send_quote_mail(@quote.customer_id,@quote.id).deliver
      WelcomeMailer.send_quote_mail_customer(@customer,@quote.id).deliver


    else
      render :text => 'Some thing went Wornge' and return false
    end
    redirect_to "/rcadmin/customers/#{@quote.customer_id}/edit"

  end


  def show_cabinet_selection
    @quote = Rcadmin::Quote.find(session[:quote_id] )
    @categories = @quote.categories
    @cabinet_types = Rcadmin::CabinetType.all
  end

  def save_cabinet
    if params["quote"]["cabinet_types_info"].blank?
      flash[:error] = 'Please select one cabinet type'
      render :action => 'show_cabinet_selection'
    else
      @quote = Rcadmin::Quote.find(session[:quote_id] )
      @quote.cabinet_type_id = params[:quote][:cabinet_type_id]
      @quote.cabinet_types_info = params[:quote][:cabinet_types_info].to_hash.to_s
     
      if @quote.save
        redirect_to :action => 'show_countertop_design'
      end
    end  
  end

  def show_countertop_design
    @quote = Rcadmin::Quote.find(session[:quote_id] )
    @categories = @quote.categories
    @countertop_designs = Rcadmin::CountertopDesign.all
  end

  def save_countertop
    if params[:quote][:countertop_designs_info].blank? 
      flash[:error] = 'Please select one countertop design'
      render :action => 'show_countertop_design'
    else
      @quote = Rcadmin::Quote.find(session[:quote_id] )
      @quote.countertop_design_id = params[:quote][:countertop_design_id]
      @quote.countertop_designs_info = params[:quote][:countertop_designs_info].to_hash.to_s
      if @quote.save
        redirect_to :action => 'show_product'
      end
    end  
  end
  
  def get_customer
    contractor_id = params["contractor_id"]
    @customer =  Rcadmin::Customer.by_contractor(contractor_id)
    render :partial => "get_customer", :object => @customer
  end

  def get_new_customer
    @rcadmin_customer = Rcadmin::Customer.new
    render :partial => "new_customer", :object => @rcadmin_customer
  end

  def get_old_customer
    @quote = Rcadmin::Quote.new
    render :partial => "old_customer", :object =>  @quote
  end
  
  def add_new_room
   # render :text => params[:rcadmin_category].inspect and return false
    @qid = session[:quote_id]
    @rcadmin_extra_category = Rcadmin::Category.new(params[:rcadmin_category])
    @rcadmin_extra_category.status = 0
   # render :text => @rcadmin_extra_category.inspect and return false
    @exist_cat_name = Rcadmin::Quote.merger_quote_name(@qid)
    if @exist_cat_name.include?(params[:rcadmin_category][:name])
      render :text => 'Room Name Already exist',:status => 404
    end
    if @rcadmin_extra_category.save
       render :partial => "all_category_with_extra", :object => @qid
    else
      return @rcadmin_customer.errors.full_messages[0]
    end
    
  end


end
