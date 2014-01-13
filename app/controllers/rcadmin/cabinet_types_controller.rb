class Rcadmin::CabinetTypesController < ApplicationController
  before_action :set_rcadmin_cabinet_type, only: [:show, :edit, :update, :destroy]

  # GET /rcadmin/cabinet_types
  # GET /rcadmin/cabinet_types.json
  def index
    @rcadmin_cabinet_types = Rcadmin::CabinetType.all
  end

  # GET /rcadmin/cabinet_types/1
  # GET /rcadmin/cabinet_types/1.json
  def show
  end

  # GET /rcadmin/cabinet_types/new
  def new
    @rcadmin_cabinet_type = Rcadmin::CabinetType.new
  end

  # GET /rcadmin/cabinet_types/1/edit
  def edit
  end

  # POST /rcadmin/cabinet_types
  # POST /rcadmin/cabinet_types.json
  def create
    @rcadmin_cabinet_type = Rcadmin::CabinetType.new(rcadmin_cabinet_type_params)
    respond_to do |format|
      if @rcadmin_cabinet_type.save
	flash[:notice] = 'Cabinet type was successfully created'
        format.html { redirect_to rcadmin_cabinet_types_url, notice: 'Cabinet type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @rcadmin_cabinet_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @rcadmin_cabinet_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rcadmin/cabinet_types/1
  # PATCH/PUT /rcadmin/cabinet_types/1.json
  def update
    respond_to do |format|
      if @rcadmin_cabinet_type.update(rcadmin_cabinet_type_params)
	flash[:notice] = 'Cabinet type was successfully updated'
        format.html { redirect_to rcadmin_cabinet_types_url, notice: 'Cabinet type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rcadmin_cabinet_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rcadmin/cabinet_types/1
  # DELETE /rcadmin/cabinet_types/1.json
  def destroy
    @rcadmin_cabinet_type.destroy
    flash[:notice] = 'Cabinet type was successfully deleted'
    respond_to do |format|
      format.html { redirect_to rcadmin_cabinet_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rcadmin_cabinet_type
      @rcadmin_cabinet_type = Rcadmin::CabinetType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rcadmin_cabinet_type_params
      params.require(:rcadmin_cabinet_type).permit(:name, :status)
    end
end
