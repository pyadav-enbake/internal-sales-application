class Rcadmin::LoginLogsController < ApplicationController
  before_filter :check_auth
  before_action :set_rcadmin_login_log, only: [:show, :edit, :update, :destroy]

  # GET /rcadmin/login_logs
  # GET /rcadmin/login_logs.json
  def index
    @rcadmin_login_logs = Rcadmin::LoginLog.all
  end

  # GET /rcadmin/login_logs/1
  # GET /rcadmin/login_logs/1.json
  def show
  end

  # GET /rcadmin/login_logs/new
  def new
    @rcadmin_login_log = Rcadmin::LoginLog.new
  end

  # GET /rcadmin/login_logs/1/edit
  def edit
  end

  # POST /rcadmin/login_logs
  # POST /rcadmin/login_logs.json
  def create
    @rcadmin_login_log = Rcadmin::LoginLog.new(rcadmin_login_log_params)

    respond_to do |format|
      if @rcadmin_login_log.save
        format.html { redirect_to @rcadmin_login_log, notice: 'Login log was successfully created.' }
        format.json { render action: 'show', status: :created, location: @rcadmin_login_log }
      else
        format.html { render action: 'new' }
        format.json { render json: @rcadmin_login_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rcadmin/login_logs/1
  # PATCH/PUT /rcadmin/login_logs/1.json
  def update
    respond_to do |format|
      if @rcadmin_login_log.update(rcadmin_login_log_params)
        format.html { redirect_to @rcadmin_login_log, notice: 'Login log was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rcadmin_login_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rcadmin/login_logs/1
  # DELETE /rcadmin/login_logs/1.json
  def destroy
    @rcadmin_login_log.destroy
    respond_to do |format|
      format.html { redirect_to rcadmin_login_logs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rcadmin_login_log
      @rcadmin_login_log = Rcadmin::LoginLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rcadmin_login_log_params
      params.require(:rcadmin_login_log).permit(:first_name, :last_name, :email, :login_time, :logout_time, :ip)
    end
end
