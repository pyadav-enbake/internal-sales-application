class Rcadmin::CountertopDesignsController < ApplicationController
  before_action :set_rcadmin_countertop_design, only: [:show, :edit, :update, :destroy]

  # GET /rcadmin/countertop_designs
  # GET /rcadmin/countertop_designs.json
  def index
    @rcadmin_countertop_designs = Rcadmin::CountertopDesign.all
  end

  # GET /rcadmin/countertop_designs/1
  # GET /rcadmin/countertop_designs/1.json
  def show
  end

  # GET /rcadmin/countertop_designs/new
  def new
    @rcadmin_countertop_design = Rcadmin::CountertopDesign.new
  end

  # GET /rcadmin/countertop_designs/1/edit
  def edit
  end

  # POST /rcadmin/countertop_designs
  # POST /rcadmin/countertop_designs.json
  def create
    @rcadmin_countertop_design = Rcadmin::CountertopDesign.new(rcadmin_countertop_design_params)

    respond_to do |format|
      if @rcadmin_countertop_design.save
        flash[:notice] = 'Countertop design was successfully created'
        format.html { redirect_to rcadmin_countertop_designs_url: 'Countertop design was successfully created.' }
        format.json { render action: 'show', status: :created, location: @rcadmin_countertop_design }
      else
        format.html { render action: 'new' }
        format.json { render json: @rcadmin_countertop_design.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rcadmin/countertop_designs/1
  # PATCH/PUT /rcadmin/countertop_designs/1.json
  def update
    respond_to do |format|
      if @rcadmin_countertop_design.update(rcadmin_countertop_design_params)
      flash[:notice] = 'Countertop design was successfully updated'
        format.html { redirect_to rcadmin_countertop_designs_url, notice: 'Countertop design was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rcadmin_countertop_design.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rcadmin/countertop_designs/1
  # DELETE /rcadmin/countertop_designs/1.json
  def destroy
    @rcadmin_countertop_design.destroy
    flash[:notice] = 'Countertop design was successfully deleted'
    respond_to do |format|
      format.html { redirect_to rcadmin_countertop_designs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rcadmin_countertop_design
      @rcadmin_countertop_design = Rcadmin::CountertopDesign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rcadmin_countertop_design_params
      params.require(:rcadmin_countertop_design).permit(:name, :status)
    end
end
