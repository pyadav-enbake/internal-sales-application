class Rcadmin::CategoriesController < ApplicationController
  before_filter :check_auth,:authenticate
  before_action :set_rcadmin_category, only: [:show, :edit, :update, :destroy]

  # GET /rcadmin/categories
  # GET /rcadmin/categories.json
  def index
    @rcadmin_categories = Rcadmin::Category.all
  end

  # GET /rcadmin/categories/1
  # GET /rcadmin/categories/1.json
  def show
  end

  # GET /rcadmin/categories/new
  def new
    @rcadmin_category = Rcadmin::Category.new
  end

  # GET /rcadmin/categories/1/edit
  def edit
  end

  # POST /rcadmin/categories
  # POST /rcadmin/categories.json
  def create
  #render :text => rcadmin_category_params.inspect and return false
    @rcadmin_category = Rcadmin::Category.new(rcadmin_category_params)

    respond_to do |format|
      if @rcadmin_category.save
		flash[:notice] = 'Category was successfully created.'
        format.html { redirect_to rcadmin_categories_url  }
        format.json { render action: 'show', status: :created, location: @rcadmin_category }
      else
        format.html { render action: 'new' }
        format.json { render json: @rcadmin_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rcadmin/categories/1
  # PATCH/PUT /rcadmin/categories/1.json
  def update
    respond_to do |format|
      if @rcadmin_category.update(rcadmin_category_params)
		flash[:notice] = 'Category was successfully updated.'
        format.html { redirect_to rcadmin_categories_url }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rcadmin_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rcadmin/categories/1
  # DELETE /rcadmin/categories/1.json
  def destroy
    @rcadmin_category.destroy
    respond_to do |format|
      flash[:notice] = 'Category was successfully deleted.'
      format.html { redirect_to rcadmin_categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rcadmin_category
      @rcadmin_category = Rcadmin::Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rcadmin_category_params
      params.require(:rcadmin_category).permit(:name,:description,:status)
    end
end
