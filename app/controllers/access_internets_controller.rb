class AccessInternetsController < ApplicationController
  before_action :set_access_internet, only: [:show, :edit, :update, :destroy]

  # GET /access_internets
  # GET /access_internets.json
  def index
    @access_internets = AccessInternet.all.order("created_at DESC")
  end

  # GET /access_internets/1
  # GET /access_internets/1.json
  def show
  end

  # GET /access_internets/new
  def new
    @access_internet = AccessInternet.new
  end

  # GET /access_internets/1/edit
  def edit
  end

  # POST /access_internets
  # POST /access_internets.json
  def create
    @access_internet = AccessInternet.new(access_internet_params)
    #@access_internet.hfc = @access_internet.hfc_cgn + @access_internet.hfc_public + @access_internet.hfc_ipv6
    #@access_internet.hfc = params[:hfc_cgn] + params[:hfc_public] + params[:hfc_ipv6]

    respond_to do |format|
      if @access_internet.save
        format.html { redirect_to @access_internet, notice: 'Access internet was successfully created.' }
        format.json { render :show, status: :created, location: @access_internet }
      else
        format.html { render :new }
        format.json { render json: @access_internet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /access_internets/1
  # PATCH/PUT /access_internets/1.json
  def update
    respond_to do |format|
      if @access_internet.update(access_internet_params)
        format.html { redirect_to @access_internet, notice: 'Access internet was successfully updated.' }
        format.json { render :show, status: :ok, location: @access_internet }
      else
        format.html { render :edit }
        format.json { render json: @access_internet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /access_internets/1
  # DELETE /access_internets/1.json
  def destroy
    @access_internet.destroy
    respond_to do |format|
      format.html { redirect_to access_internets_url, notice: 'Access internet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_access_internet
      @access_internet = AccessInternet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def access_internet_params
      params.require(:access_internet).permit(:total_traffic, :hfc_cgn, :hfc_public, :hfc_ipv6, :hfc, :mobile_cgn, :mobile_corporate, :mobile_ipv6, :mobile, :mobile_olo, :corporate, :cache_in)
    end
end
