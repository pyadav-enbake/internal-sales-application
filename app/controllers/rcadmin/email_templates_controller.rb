class Rcadmin::EmailTemplatesController < ApplicationController
  before_filter :check_auth,:authenticate
  before_action :set_rcadmin_email_template, only: [:show, :edit, :update, :destroy]

  # GET /rcadmin/email_templates
  # GET /rcadmin/email_templates.json
  def index
    @rcadmin_email_templates = Rcadmin::EmailTemplate.all
  end

  # GET /rcadmin/email_templates/1
  # GET /rcadmin/email_templates/1.json
  def show
  end

  # GET /rcadmin/email_templates/new
  def new
    @rcadmin_email_template = Rcadmin::EmailTemplate.new
  end

  # GET /rcadmin/email_templates/1/edit
  def edit
  end

  # POST /rcadmin/email_templates
  # POST /rcadmin/email_templates.json
  def create
    @rcadmin_email_template = Rcadmin::EmailTemplate.new(rcadmin_email_template_params)

    respond_to do |format|
      if @rcadmin_email_template.save
		flash[:notice] = 'Email template was successfully created.'
        format.html { redirect_to rcadmin_email_templates_url, notice: 'Email template was successfully created.' }
        format.json { render action: 'show', status: :created, location: @rcadmin_email_template }
      else
        format.html { render action: 'new' }
        format.json { render json: @rcadmin_email_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rcadmin/email_templates/1
  # PATCH/PUT /rcadmin/email_templates/1.json
  def update
    respond_to do |format|
      if @rcadmin_email_template.update(rcadmin_email_template_params)
        flash[:notice] = 'Email template was successfully updated.'
        format.html { redirect_to rcadmin_email_templates_url, notice: 'Email template was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rcadmin_email_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rcadmin/email_templates/1
  # DELETE /rcadmin/email_templates/1.json
  def destroy
    @rcadmin_email_template.destroy
    respond_to do |format|
	  flash[:notice] = 'Email template was successfully deleted.'
      format.html { redirect_to rcadmin_email_templates_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rcadmin_email_template
      @rcadmin_email_template = Rcadmin::EmailTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rcadmin_email_template_params
      params.require(:rcadmin_email_template).permit(:template_name, :message_body)
    end
end
