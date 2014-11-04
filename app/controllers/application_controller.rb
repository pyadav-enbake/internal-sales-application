class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_user
 # before_filter :authenticate

 before_filter do
   @current_user = current_user
 end
  
  layout :get_layout 

  def get_layout
      if devise_controller?
          'devise'
      elsif controller_name == 'quote' && action_name == 'quote_preview'
          'mail_preview'
      else 
          'application'
      end
  end

  #WelcomeMailer.testmail().deliver
  def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:name, :email) }
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation,:first_name,:last_name,:terms_and_conditions,:role) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation,:first_name,:last_name,:role,:quote_category) }
  end

  def after_sign_in_path_for(resource)
      @current_user = Rcadmin::Admin.find(resource[:id])
      session[:username] = resource[:username]
      session[:email] = resource[:email]
      session[:admin_id] = resource[:id]
      session[:first_name] = resource[:first_name]
      session[:last_name] = resource[:last_name]

      @loginlogs = Rcadmin::LoginLog.new
      @loginlogs.email = resource[:email]
      @loginlogs.login_time = Time.now
      @loginlogs.first_name = resource[:first_name]
      @loginlogs.last_name = resource[:last_name]
      @loginlogs.logout_time = ""
      @loginlogs.ip = request.remote_ip
      @loginlogs.role = current_user.role
      @loginlogs.save
      session[:login_log_id] = @loginlogs.id    

      dashboard_url_path
  end
  def after_sign_up_path_for(resource)
      new_admin_session_path
  end


  def check_auth

      if !admin_signed_in?
          redirect_to "/"
      end
  end

  def authenticate
      if current_user
          #render :text => params.inspect and return false
          if current_user.role == 'admin'
            return true
          elsif current_user.role == 'sales_admin' && (params[:controller] != 'rcadmin/customers' && params[:controller] != 'rcadmin/dashboard') &&( params[:controller] == 'rcadmin/administrators' && current_user.id != params[:id].to_i)
              redirect_to "/error404"
          end
          #if current_user.role == 'admin' && params[:controller] == 'rcadmin/customers'
          #	redirect_to "/error404"
          #end
      end
  end

  private

  alias :current_user :current_admin



end
