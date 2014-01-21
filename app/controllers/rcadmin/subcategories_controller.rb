class Rcadmin::SubcategoriesController < ApplicationController
  before_action :set_rcadmin_subcategory, only: [:show, :edit, :update, :destroy]

  # GET /rcadmin/subcategories
  # GET /rcadmin/subcategories.json
  def index
    @rcadmin_subcategories = Rcadmin::Subcategory.all
  end

  # GET /rcadmin/subcategories/1
  # GET /rcadmin/subcategories/1.json
  def show
  end

  # GET /rcadmin/subcategories/new
  def new
    @rcadmin_subcategory = Rcadmin::Subcategory.new
  end

  # GET /rcadmin/subcategories/1/edit
  def edit
  end

  # POST /rcadmin/subcategories
  # POST /rcadmin/subcategories.json
  def create
    @rcadmin_subcategory = Rcadmin::Subcategory.new(rcadmin_subcategory_params)

    respond_to do |format|
      if @rcadmin_subcategory.save
        flash[:notice] = 'Product Type was successfully created.' 
        format.html { redirect_to rcadmin_subcategories_url, notice: 'Product Type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @rcadmin_subcategory }
      else
        format.html { render action: 'new' }
        format.json { render json: @rcadmin_subcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rcadmin/subcategories/1
  # PATCH/PUT /rcadmin/subcategories/1.json
  def update
    respond_to do |format|
      if @rcadmin_subcategory.update(rcadmin_subcategory_params)
        flash[:notice] = 'Product Type was successfully updated.' 
        format.html { redirect_to rcadmin_subcategories_url, notice: 'Product Type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rcadmin_subcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rcadmin/subcategories/1
  # DELETE /rcadmin/subcategories/1.json
  def destroy
    @rcadmin_subcategory.destroy
    respond_to do |format|
	  flash[:notice] = 'Product Type was successfully deleted.' 
      format.html { redirect_to rcadmin_subcategories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rcadmin_subcategory
      @rcadmin_subcategory = Rcadmin::Subcategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rcadmin_subcategory_params
      params.require(:rcadmin_subcategory).permit(:category_id, :name, :status)
    end
end
