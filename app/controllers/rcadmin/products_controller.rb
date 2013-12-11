class Rcadmin::ProductsController < ApplicationController
	before_filter :check_auth,:authenticate
  before_action :set_rcadmin_product, only: [:show, :edit, :update, :destroy]

  # GET /rcadmin/products
  # GET /rcadmin/products.json
  def index
    @rcadmin_products = Rcadmin::Product.all
  end

  # GET /rcadmin/products/1
  # GET /rcadmin/products/1.json
  def show
  end

  # GET /rcadmin/products/new
  def new
    @rcadmin_product = Rcadmin::Product.new
  end

  # GET /rcadmin/products/1/edit
  def edit
	@dimension_categories =Rcadmin::DimensionCategory.find_by_ctype(@rcadmin_product.dimension.dimension_category.category_type)
  end

  # POST /rcadmin/products
  # POST /rcadmin/products.json
  def create
    @rcadmin_product = Rcadmin::Product.new(rcadmin_product_params)
	
    respond_to do |format|
      if @rcadmin_product.save
		flash[:notice] = 'Product was successfully created.'
        format.html { redirect_to rcadmin_products_url, notice: 'Product was successfully created.' }
        format.json { render action: 'show', status: :created, location: @rcadmin_product }
      else
        format.html { render action: 'new' }
        format.json { render json: @rcadmin_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rcadmin/products/1
  # PATCH/PUT /rcadmin/products/1.json
  def update
    respond_to do |format|
      if @rcadmin_product.update(rcadmin_product_params)
		flash[:notice] = 'Product was successfully updated.'
        format.html { redirect_to rcadmin_products_url, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rcadmin_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rcadmin/products/1
  # DELETE /rcadmin/products/1.json
  def destroy
    @rcadmin_product.destroy
    respond_to do |format|
	  flash[:notice] = 'Product was successfully deleted.'
      format.html { redirect_to rcadmin_products_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rcadmin_product
      @rcadmin_product = Rcadmin::Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rcadmin_product_params
      params.require(:rcadmin_product).permit(:category_id,:subcategory_id, :title,:description,:price,:status)
    end
end
