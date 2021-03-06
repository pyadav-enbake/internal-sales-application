class Devise::SessionsController < DeviseController
  prepend_before_filter :require_no_authentication, :only => [ :new, :create ]
  prepend_before_filter :allow_params_authentication!, :only => :create
  #prepend_before_filter :only => [ :create, :destroy ] { request.env["devise.skip_timeout"] = true }
  #include Devise::Controllers::InternalHelpers

  # GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end

  # POST /resource/sign_in
  def create
     

    if params[:admin]["email"].blank? 
		flash[:error] = "Email should n't Blank"
    end
    if params[:admin]["password"].blank? 
		flash[:error] = "Password should n't Blank"
    end
    if resource.nil? 
		flash[:error] = "Invalid Email or Password"
    end
    
    
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) 
    
    sign_in(resource_name, resource)
	
    yield resource if block_given?


    #respond_with resource,redirect_to :controller => 'rcadmin/dashboard', :action => 'index'
    respond_with resource, :location => after_sign_in_path_for(resource)
  end

  # DELETE /resource/sign_out
  def destroy
	@admin =  Rcadmin::LoginLog.find(session[:login_log_id])
	@admin.logout_time= Time.now
	@admin.save
	#redirect_path = after_sign_out_path_for(resource_name)
	redirect_path = new_admin_session_path
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    yield resource if block_given?

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.all { head :no_content }
      format.any(*navigational_formats) { redirect_to redirect_path }
    end
  end

  protected

  def sign_in_params
  #  devise_parameter_sanitizer.sanitize(:sign_in)
  end

  def serialize_options(resource)
    methods = resource_class.authentication_keys.dup
    methods = methods.keys if methods.is_a?(Hash)
    methods << :password if resource.respond_to?(:password)
    { :methods => methods, :only => [:password] }
  end

  def auth_options
    { :scope => resource_name, :recall => "#{controller_path}#new" }
  end
end
