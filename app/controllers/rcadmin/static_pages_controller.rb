class Rcadmin::StaticPagesController < ApplicationController
  before_action :set_rcadmin_static_page, only: [:show, :edit, :update, :destroy]

  # GET /rcadmin/static_pages
  # GET /rcadmin/static_pages.json
  def index
    @rcadmin_static_pages = Rcadmin::StaticPage.all
  end

  # GET /rcadmin/static_pages/1
  # GET /rcadmin/static_pages/1.json
  def show
  end

  # GET /rcadmin/static_pages/new
  def new
    @rcadmin_static_page = Rcadmin::StaticPage.new
  end

  # GET /rcadmin/static_pages/1/edit
  def edit
  end

  # POST /rcadmin/static_pages
  # POST /rcadmin/static_pages.json
  def create
    @rcadmin_static_page = Rcadmin::StaticPage.new(rcadmin_static_page_params)

    respond_to do |format|
      if @rcadmin_static_page.save
		flash[:notice] = 'Static page was successfully created.'
        format.html { redirect_to rcadmin_static_pages_url, notice: 'Static page was successfully created.' }
        format.json { render action: 'show', status: :created, location: @rcadmin_static_page }
      else
        format.html { render action: 'new' }
        format.json { render json: @rcadmin_static_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rcadmin/static_pages/1
  # PATCH/PUT /rcadmin/static_pages/1.json
  def update
    respond_to do |format|
      if @rcadmin_static_page.update(rcadmin_static_page_params)
        flash[:notice] = 'Static page was successfully updated.'
        format.html { redirect_to rcadmin_static_pages_url, notice: 'Static page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rcadmin_static_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rcadmin/static_pages/1
  # DELETE /rcadmin/static_pages/1.json
  def destroy
    @rcadmin_static_page.destroy
    respond_to do |format|
      flash[:notice] = 'Static page was successfully deleted.'
      format.html { redirect_to rcadmin_static_pages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rcadmin_static_page
      @rcadmin_static_page = Rcadmin::StaticPage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rcadmin_static_page_params
      params.require(:rcadmin_static_page).permit(:name, :content)
    end
end
