class Rcadmin::FaqsController < ApplicationController
  before_action :set_rcadmin_faq, only: [:show, :edit, :update, :destroy]

  # GET /rcadmin/faqs
  # GET /rcadmin/faqs.json
  def index
    @rcadmin_faqs = Rcadmin::Faq.all
  end

  # GET /rcadmin/faqs/1
  # GET /rcadmin/faqs/1.json
  def show
  end

  # GET /rcadmin/faqs/new
  def new
    @rcadmin_faq = Rcadmin::Faq.new
  end

  # GET /rcadmin/faqs/1/edit
  def edit
  end

  # POST /rcadmin/faqs
  # POST /rcadmin/faqs.json
  def create
    @rcadmin_faq = Rcadmin::Faq.new(rcadmin_faq_params)

    respond_to do |format|
      if @rcadmin_faq.save
		flash[:notice] = 'Faq was successfully created.'
        format.html { redirect_to rcadmin_faqs_url, notice: 'Faq was successfully created.' }
        format.json { render action: 'show', status: :created, location: @rcadmin_faq }
      else
        format.html { render action: 'new' }
        format.json { render json: @rcadmin_faq.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rcadmin/faqs/1
  # PATCH/PUT /rcadmin/faqs/1.json
  def update
    respond_to do |format|
		flash[:notice] = 'Faq was successfully updeted.'
      if @rcadmin_faq.update(rcadmin_faq_params)
        format.html { redirect_to rcadmin_faqs_url, notice: 'Faq was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rcadmin_faq.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rcadmin/faqs/1
  # DELETE /rcadmin/faqs/1.json
  def destroy
    @rcadmin_faq.destroy
    respond_to do |format|
	  flash[:notice] = 'Faq was successfully deleted.'
      format.html { redirect_to rcadmin_faqs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rcadmin_faq
      @rcadmin_faq = Rcadmin::Faq.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rcadmin_faq_params
      params.require(:rcadmin_faq).permit(:faq_category_id, :question, :answer, :display_order, :status)
    end
end
