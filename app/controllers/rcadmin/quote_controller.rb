class Rcadmin::QuoteController < ApplicationController

  protect_from_forgery except: :get_customer
  before_action :check_auth,:authenticate

  before_action :find_quote, only: [:room, :docs, :cover_sheet, :grid, :remove_category, :print, :show, :update, :edit]
  before_action :find_quote_by_session, only: [:show_category, :quote_preview]

  def index
    @rcadmin_customer = Rcadmin::Customer.new
    session[:quote_id] = nil
    @quote = Rcadmin::Quote.new
    @categories = current_admin.categories
  end


  def search
    @quotes = current_user.quotes.includes([:contractor, :customer, :retailer]).search(params[:query])
  end


  def room
    @category = @quote.categories.find(params[:category_id])
  end



  def quotations
    @rcadmin_quotes = current_user.quotes.includes(:contractor).order("created_at DESC")
  end

  def docs
  end

  def cover_sheet
    @categories = @quote.categories
    @customer = @quote.customer
    @quote_products_sum = @quote.quote_product.group(:category_id).sum(:total_price)
  end

  def grid
    @contractor = @quote.contractor || Rcadmin::Contractor.new
    @customer = @quote.customer || Rcadmin::Customer.new
    @categories = @quote.categories
    if params[:template_id] == "9"
      if params[:category_id].present?
        @category_id = @quote.categories.find(params[:category_id]).try(:id)
      else
        @category_id = @quote.categories.first.try(:id)
      end
    end
    if params[:template_id] == "8"
      if params[:category_ids].present?
        @category_ids = @categories.select { |category| params[:category_ids].present? && params[:category_ids].include?(category.id.to_s) }.map(&:id)
      else
        @category_ids = @categories.limit(3).map(&:id)
      end
    end
    
    respond_to do |format|
      if request.xhr?
        format.html { render partial: "rcadmin/quote/templates/grid#{params[:template_id]||1}_page", locals: { category_id: params[:category_id], page: 0 } }
      else
        format.html { render template: "rcadmin/quote/templates/grid#{params[:template_id]||1}", layout: false }
      end
      format.js { render template: "rcadmin/quote/templates/grid#{params[:template_id]||1}" }
    end
  end

  def remove_category
    @quote.remove_category params[:category_id]
    render  json: {success: true, count: @quote.category_ids.length}
  end

  def save_customer_deatils

    @quote = Rcadmin::Quote.new( params[:rcadmin_quote])
    @quote.customer_id = params[:rcadmin_quote][:customer_id]
    if @quote.save
      session[:quote_id] = @quote.id
      if @quote.retailer.nil? and @quote.contractor.default_contractor?
        redirect_to new_quote_retailer_url(@quote)
      else
        redirect_to :action => 'show_category'
      end
    else
      render :action=> 'index'
    end
  end

  def show_category
    if session[:quote_id] != nil
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
    if @categories.empty?
      redirect_to select_quote_category_url and return;
    end
  end
  
  def auto_save_product
    @quote = Rcadmin::Quote.find(session[:quote_id] )
    @quote_product = @quote.quote_products.new
    if params[:quote_product_id].present?
      @quote_product = Rcadmin::QuoteProduct.find(params[:quote_product_id])
    end
    @quote_product.category_id = params[:category_id]
    @quote_product.product_id = params[:product_id]
    @quote_product.quantity = params[:quantity]
    @quote_product.total_price = params[:totalPrice]
    @quote_product.product_type = params[:product_type]
    @quote_product.quote_price = params[:price]
    @quote_product.hidden = params[:hideProduct]
    @quote_product.header_option = params[:optionProduct] == "true" ? "Yes" : "No"
    @quote_product.save
     
    respond_to do |format|
      format.json { render json: {:msg => 'success', :id => @quote_product.id} }
    end
  end

  def send_quote
    @quote = Rcadmin::Quote.find(session[:quote_id] )
    #@quote.quote_product.destroy_all
    @quote.status = 0
    #@quote.update_attributes(params[:quote])
    @customer = @quote.customer
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


  def selections
    @quote = Rcadmin::Quote.includes(product_type_selections: [:product_type, :selection_type]).where(id: params[:id]).first
    @categories = @quote.categories
    @cabinet_types = ::CabinetType.includes(:selections).order(:id)
  end




  def get_customer
      contractor_id = params["contractor_id"]
      @contractor = current_user.contractors.find(contractor_id)
      render :partial => "get_customer", :object => @contractor
  end

  def print
    @contractor = @quote.contractor
    @customer = @quote.customer
    @admin = current_user
    render layout: false, template: 'rcadmin/quote/print'
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
      @customer = current_user.customers.find(params[:customer_id])
      @rcadmin_quotes = @customer.quotes.preload(:contractor)

    elsif params[:search].blank?
      @rcadmin_quotes = current_user.quotes.joins(:contractor).where(contractors: { id: params[:id] }).
        preload(:contractor)
    else
      #@rcadmin_quotes = Rcadmin::Contractor.where("first_name like '%#{params[:search]}%' or last_name like '%#{params[:search]}% or email like '%#{params[:search]}%'").map{|c|c.quotes}
      @rcadmin_quotes = current_user.contractors.where("first_name like '%#{params[:search]}%' or last_name like '%#{params[:search]}%' or email like '%#{params[:search]}%'").map{|c|c.quotes}.flatten
    end

    @rcadmin_quotes = @rcadmin_quotes.order("created_at DESC")
  end

  def edit
    session[:quote_id] = @quote.id
    redirect_to select_quote_product_path
  end

  def destroy
  end

  def update
    @quote.update(params[:quote])
    respond_to do |format|
      message = ' Your selections has been successfully saved'
      format.html {  redirect_to( (:back || selections_rcadmin_quote_path(id: @quote.id)), notice: message) }
      format.js
    end
  end

  def show
  end

  def quote_preview
      #@quote.quote_product.destroy_all
      @quote.status = 0
      
      #delete quote_product attributes
      params[:quote].delete :quote_products_attributes
      
      @quote.update_attributes(params[:quote])
       # To handle if delivery is false
       @quote.deliver = params[:quote][:deliver].present? ? true : false
       @quote.save
      @customer = @quote.customer

    if params.has_key?(:draft)
      redirect_to create_quote_path, notice: 'Your Quote has been saved as a draft.'
    else
      if params.has_key?(:calculator)
        content = render_to_string(partial: 'rcadmin/quote/calculator', collection: @quote.quote_categories.select{|i| i.product_total > 0.0}, as: :object)
        content += render_to_string(partial: 'rcadmin/quote/option_calculator')
        self.response_body = content
      else
        @admin = current_user
        render template: 'welcome_mailer/send_quote_mail_customer'
      end
    end
  end

  private


  def find_quote
    @rcadmin_quotes = @quote = current_user.quotes.find params[:id] 
  end

  def find_quote_by_session
    @quote = current_user.quotes.find(session[:quote_id] ) if session[:quote_id]
  end

end
