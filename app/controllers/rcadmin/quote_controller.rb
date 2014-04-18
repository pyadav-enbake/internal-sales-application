class Rcadmin::QuoteController < ApplicationController

  protect_from_forgery except: :get_customer
  before_action :check_auth,:authenticate

  def index
    @rcadmin_customer = Rcadmin::Customer.new
    session[:quote_id] = nil
    @quote = Rcadmin::Quote.new
    @categories = current_admin.categories
  end


  def quotations
    @rcadmin_quotes = current_user.quotes.includes(:contractor).order("created_at DESC")
  end

  def docs
    @quote = Rcadmin::Quote.find params[:id] 
  end

  def cover_sheet
    @quote = Rcadmin::Quote.find params[:id] 
    @categories = @quote.categories
    @customer = @quote.customer
    @quote_products_sum = @quote.quote_product.group(:category_id).sum(:total_price)
  end

  def grid
    @quote = Rcadmin::Quote.find params[:id] 
    @contractor = @quote.contractor || Rcadmin::Contractor.new
    @customer = @quote.customer || Rcadmin::Customer.new
    @categories = @quote.categories
    render template: "rcadmin/quote/templates/grid#{params[:template_id]||1}", layout: false
  end

  def remove_category
    @quote = Rcadmin::Quote.find params[:id] 
    @quote.remove_category params[:category_id]
    render  json: {success: true, count: @quote.category_ids.length}
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
      @categories = current_admin.categories
      @selected_category = @quote.category.split(',') if !@quote.category.nil?
    else
      redirect_to create_quote_path
    end

  end

  def save_category_deatils
    #render :text => params.inspect and return false
              @quote = Rcadmin::Quote.find(session[:quote_id] )
      if params["all"] == "true"
          if params["quote"]["category"].blank?
              flash[:error] = 'Please select any category'
              render :action => 'show_category'
          else
              @quote = Rcadmin::Quote.find(session[:quote_id] )
              params[:quote][:category] = Rcadmin::Category.all.map{|category|category.id}.to_s.gsub("[","""]").gsub("]","")
              @quote.category_ids = params[:quote][:category]
              if @quote.save
                  redirect_to :action => 'show_product'
                  #redirect_to :action => 'show_cabinet_selection'
              end
          end
      else
          params["quote"]["category"].reject!{|a| a==""} 
          if params[:quote][:category].nil? or params["quote"]["category"].blank?
              flash[:error] = 'Please select any category'
              render :action => 'show_category'
          else
              @quote = Rcadmin::Quote.find(session[:quote_id] )
              @quote.category_ids = params[:quote][:category]
              if @quote.save
                  redirect_to :action => 'show_product'
                  # redirect_to :action => 'show_cabinet_selection'
              end
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
    @categories =  @quote.categories # Rooms 
  end

  def send_quote
    @quote = Rcadmin::Quote.find(session[:quote_id] )
    @quote.quote_product.destroy_all
    @quote.status = 0
    @quote.update_attributes(params[:quote])
    @customer = Rcadmin::Customer.find(@quote.customer_id)
    WelcomeMailer.send_quote_mail_customer(@quote.id).deliver
    @quote.sent_to_client!
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
          WelcomeMailer.send_quote_mail_customer(@quote.id).deliver
      else
          render :text => 'Some thing went Wornge' and return false
      end
      redirect_to "/rcadmin/customers/#{@quote.customer_id}/edit"

  end


  def  selections
    @quote = Rcadmin::Quote.find(params[:id])
    @categories = @quote.categories
    @cabinet_types = ::CabinetType.includes(:selections).order(:id)
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
    @rcadmin_extra_category = current_admin.categories.build params[:rcadmin_category]
    @rcadmin_extra_category.status = 0
    # render :text => @rcadmin_extra_category.inspect and return false
    @exist_cat_name = Rcadmin::Quote.merger_quote_name(@qid)
    if @exist_cat_name.include?(params[:rcadmin_category][:name])
      render :text => 'Room Name Already exist',:status => 404
      return
    end
    if @rcadmin_extra_category.save
      render :partial => "all_category_with_extra", :object => @qid
      return 
    else
      return @rcadmin_extra_category.errors.full_messages[0]
    end

  end

  def display_quotes
    if params[:customer_id]
      @customer = Rcadmin::Customer.where(id: params[:customer_id]).first
      @rcadmin_quotes = @customer.quotes

    elsif params[:search].blank?
      @rcadmin_quotes = Rcadmin::Quote.where(:contractor_id => params[:id])
    else
      #@rcadmin_quotes = Rcadmin::Contractor.where("first_name like '%#{params[:search]}%' or last_name like '%#{params[:search]}% or email like '%#{params[:search]}%'").map{|c|c.quotes}
      @rcadmin_quotes = Rcadmin::Contractor.where("first_name like '%#{params[:search]}%' or last_name like '%#{params[:search]}%' or email like '%#{params[:search]}%'").map{|c|c.quotes}.flatten
    end

    @rcadmin_quotes = @rcadmin_quotes.order("created_at DESC")
  end

  def edit
  end

  def destroy
  end

  def update
    @quote = Rcadmin::Quote.find params[:id]
    @quote.update(params[:quote])
    redirect_to :back || selections_rcadmin_quote_path(id: @quote.id)
  end

  def show
      @rcadmin_quotes = Rcadmin::Quote.find(params[:id])
      unless  @rcadmin_quotes.cabinet_types_info.nil?
        cabinet_types = @rcadmin_quotes.cabinet_types_info.gsub("=>", ":")
      end
      @json_cabinet_types = JSON.parse(cabinet_types || '{}')
      unless  @rcadmin_quotes.countertop_designs_info.nil?
        countertop = @rcadmin_quotes.countertop_designs_info.gsub("=>", ":")
      end
      @json_countertop = JSON.parse(countertop || '{}')

  end

  def quote_preview
      @quote = Rcadmin::Quote.find(session[:quote_id] )
      @quote.quote_product.destroy_all
      @quote.status = 0
      @quote.update_attributes(params[:quote])
      @customer = Rcadmin::Customer.find(@quote.customer_id)

    if params.has_key?(:draft)
      redirect_to create_quote_path, notice: 'Your Quote has been saved as a draft.'
    else
      render template: 'welcome_mailer/send_quote_mail_customer'
    end
  end
end
