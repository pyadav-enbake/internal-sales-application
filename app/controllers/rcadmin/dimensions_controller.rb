class Rcadmin::DimensionsController < ApplicationController
  before_action :set_rcadmin_dimension, only: [:show, :edit, :update, :destroy]

  # GET /rcadmin/dimensions
  # GET /rcadmin/dimensions.json
  def index
    @rcadmin_dimensions = Rcadmin::Dimension.all
  end

  # GET /rcadmin/dimensions/1
  # GET /rcadmin/dimensions/1.json
  def show
  end

  # GET /rcadmin/dimensions/new
  def new
    @rcadmin_dimension = Rcadmin::Dimension.new
    @rcadmin_dimension_categories =  []
    #render :text => @rcadmin_dimension_categories.inspect and return false
  end

  # GET /rcadmin/dimensions/1/edit
  def edit
	@rcadmin_dimension_categories =  Rcadmin::DimensionCategory.find_by_ctype(@rcadmin_dimension.dimension_category.category_type)
  end

  # POST /rcadmin/dimensions
  # POST /rcadmin/dimensions.json
  def create
    @rcadmin_dimension = Rcadmin::Dimension.new(rcadmin_dimension_params)
    @rcadmin_dimension_categories = []
   if params[:dimension][:category_type] == ""
    flash[:errors] = "Dimension category type can't blank."
    #render action: 'new'
   end
    respond_to do |format|
      if @rcadmin_dimension.save
       flash[:notice] = 'Dimension was successfully created.'
        format.html { redirect_to rcadmin_dimensions_url, notice: 'Dimension was successfully created.' }
        format.json { render action: 'show', status: :created, location: @rcadmin_dimension }
      else
        format.html { render action: 'new' }
        format.json { render json: @rcadmin_dimension.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rcadmin/dimensions/1
  # PATCH/PUT /rcadmin/dimensions/1.json
  def update
    respond_to do |format|
      if @rcadmin_dimension.update(rcadmin_dimension_params)
      flash[:notice] = 'Dimension was successfully updated.'
        format.html { redirect_to rcadmin_dimensions_url, notice: 'Dimension was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rcadmin_dimension.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rcadmin/dimensions/1
  # DELETE /rcadmin/dimensions/1.json
  def destroy
    @rcadmin_dimension.destroy
    respond_to do |format|
    flash[:notice] = 'Dimension was successfully deleted.'
      format.html { redirect_to rcadmin_dimensions_url }
      format.json { head :no_content }
    end
  end
  
  def ajax_call
  @rcadmin_dimension_categories =  Rcadmin::DimensionCategory.where("category_type IN (?)", ['upper_cabintes']).to_a
    respond_to do |format|
      #format.html { redirect_to rcadmin_dimensions_url }
      format.html {  }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rcadmin_dimension
      @rcadmin_dimension = Rcadmin::Dimension.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rcadmin_dimension_params
      params.require(:rcadmin_dimension).permit(:dimension_category_id, :lower_range, :upper_range)
    end
end
