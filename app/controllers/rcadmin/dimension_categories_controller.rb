class Rcadmin::DimensionCategoriesController < ApplicationController
  before_filter :check_auth,:authenticate
  before_action :set_rcadmin_dimension_category, only: [:show, :edit, :update, :destroy]

  # GET /rcadmin/dimension_categories
  # GET /rcadmin/dimension_categories.json
  def index
    @rcadmin_dimension_categories = Rcadmin::DimensionCategory.all
  end

  # GET /rcadmin/dimension_categories/1
  # GET /rcadmin/dimension_categories/1.json
  def show
  end

  # GET /rcadmin/dimension_categories/new
  def new
    @rcadmin_dimension_category = Rcadmin::DimensionCategory.new
  end

  # GET /rcadmin/dimension_categories/1/edit
  def edit
  end

  # POST /rcadmin/dimension_categories
  # POST /rcadmin/dimension_categories.json
  def create
  #render :text => rcadmin_dimension_category_params.inspect and return false
    @rcadmin_dimension_category = Rcadmin::DimensionCategory.new(rcadmin_dimension_category_params)

    respond_to do |format|
      if @rcadmin_dimension_category.save
      flash[:notice] = 'Dimension category was successfully created.' 
        format.html { redirect_to rcadmin_dimension_categories_url }
        format.json { render action: 'show', status: :created, location: @rcadmin_dimension_category }
      else
        format.html { render action: 'new' }
        format.json { render json: @rcadmin_dimension_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rcadmin/dimension_categories/1
  # PATCH/PUT /rcadmin/dimension_categories/1.json
  def update
    respond_to do |format|
      if @rcadmin_dimension_category.update(rcadmin_dimension_category_params)
		flash[:notice] = 'Dimension category was successfully updated.'
        format.html { redirect_to rcadmin_dimension_categories_url }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rcadmin_dimension_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rcadmin/dimension_categories/1
  # DELETE /rcadmin/dimension_categories/1.json
  def destroy
    @rcadmin_dimension_category.destroy
    respond_to do |format|
	  flash[:notice] = 'Dimension category was successfully deleted.'
      format.html { redirect_to rcadmin_dimension_categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rcadmin_dimension_category
      @rcadmin_dimension_category = Rcadmin::DimensionCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rcadmin_dimension_category_params
      params.require(:rcadmin_dimension_category).permit(:name,:category_type)
    end
end
