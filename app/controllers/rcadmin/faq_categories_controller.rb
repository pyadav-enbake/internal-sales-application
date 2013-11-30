class Rcadmin::FaqCategoriesController < ApplicationController
  before_action :set_rcadmin_faq_category, only: [:show, :edit, :update, :destroy]

  # GET /rcadmin/faq_categories
  # GET /rcadmin/faq_categories.json
  def index
    @rcadmin_faq_categories = Rcadmin::FaqCategory.all
  end

  # GET /rcadmin/faq_categories/1
  # GET /rcadmin/faq_categories/1.json
  def show
  end

  # GET /rcadmin/faq_categories/new
  def new
    @rcadmin_faq_category = Rcadmin::FaqCategory.new
  end

  # GET /rcadmin/faq_categories/1/edit
  def edit
  end

  # POST /rcadmin/faq_categories
  # POST /rcadmin/faq_categories.json
  def create
    
    @rcadmin_faq_category = Rcadmin::FaqCategory.new(rcadmin_faq_category_params)

    respond_to do |format|
      if @rcadmin_faq_category.save
		flash[:notice] = 'Faq category was successfully created.'
        format.html { redirect_to rcadmin_faq_categories_url, notice: 'Faq category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @rcadmin_faq_category }
      else
        format.html { render action: 'new' }
        format.json { render json: @rcadmin_faq_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rcadmin/faq_categories/1
  # PATCH/PUT /rcadmin/faq_categories/1.json
  def update
    respond_to do |format|
      if @rcadmin_faq_category.update(rcadmin_faq_category_params)
		flash[:notice] = 'Faq category was successfully updated.'
        format.html { redirect_to rcadmin_faq_categories_url, notice: 'Faq category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rcadmin_faq_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rcadmin/faq_categories/1
  # DELETE /rcadmin/faq_categories/1.json
  def destroy
    @rcadmin_faq_category.destroy
    respond_to do |format|
		flash[:notice] = 'Faq category was successfully deleted.'
      format.html { redirect_to rcadmin_faq_categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rcadmin_faq_category
      @rcadmin_faq_category = Rcadmin::FaqCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rcadmin_faq_category_params
      params.require(:rcadmin_faq_category).permit(:name, :description, :display_order, :status)
    end
end
