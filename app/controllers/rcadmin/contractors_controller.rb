class Rcadmin::ContractorsController < ApplicationController
  before_action :check_auth,:authenticate
  before_action :set_rcadmin_contractor, only: [:show, :edit, :update, :destroy]

  # GET /rcadmin/contractors
  # GET /rcadmin/contractors.json
  def index
  
    if (@current_user.role == "admin")
      @rcadmin_contractors = Rcadmin::Contractor.all
    else
      @rcadmin_contractors = Rcadmin::Contractor.find_by_adminid(@current_user.id)
    end
   # render :text => @rcadmin_contractors.inspect and return false
  end

  # GET /rcadmin/contractors/1
  # GET /rcadmin/contractors/1.json
  def show
  end

  # GET /rcadmin/contractors/new
  def new
    @rcadmin_contractor = Rcadmin::Contractor.new
  end

  # GET /rcadmin/contractors/1/edit
  def edit
  end

  # POST /rcadmin/contractors
  # POST /rcadmin/contractors.json
  def create
    @rcadmin_contractor = Rcadmin::Contractor.new(rcadmin_contractor_params)

    respond_to do |format|
      if @rcadmin_contractor.save
	flash[:notice] = 'Contractor was successfully created'
        format.html { redirect_to rcadmin_contractors_url }
        format.json { render action: 'show', status: :created, location: @rcadmin_contractor }
      else
        format.html { render action: 'new' }
        format.json { render json: @rcadmin_contractor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rcadmin/contractors/1
  # PATCH/PUT /rcadmin/contractors/1.json
  def update
    respond_to do |format|
      if @rcadmin_contractor.update(rcadmin_contractor_params)
	flash[:notice] = 'Contractor was successfully updated'
        format.html { redirect_to rcadmin_contractors_url }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rcadmin_contractor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rcadmin/contractors/1
  # DELETE /rcadmin/contractors/1.json
  def destroy
    @rcadmin_contractor.destroy
    respond_to do |format|
      flash[:notice] = 'Contractor was successfully deleted'
      format.html { redirect_to rcadmin_contractors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rcadmin_contractor
      @rcadmin_contractor = Rcadmin::Contractor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rcadmin_contractor_params
      params.require(:rcadmin_contractor).permit(:admin_id, :first_name, :last_name, :email, :state, :city, :address, :zip, :phone, :status,:company_name)
    end
end
