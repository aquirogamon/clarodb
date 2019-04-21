class CacheudniInterfacesController < ApplicationController
  before_action :set_cacheudni_interface, only: [:show, :edit, :update, :destroy]

  # GET /cacheudni_interfaces
  # GET /cacheudni_interfaces.json
  def index
    @cacheudni_interfaces = CacheudniInterface.all
  end

  # GET /cacheudni_interfaces/1
  # GET /cacheudni_interfaces/1.json
  def show
  end

  # GET /cacheudni_interfaces/new
  def new
    @cacheudni_interface = CacheudniInterface.new
  end

  # GET /cacheudni_interfaces/1/edit
  def edit
  end

  # POST /cacheudni_interfaces
  # POST /cacheudni_interfaces.json
  def create
    @cacheudni_interface = CacheudniInterface.new(cacheudni_interface_params)

    respond_to do |format|
      if @cacheudni_interface.save
        format.html { redirect_to @cacheudni_interface, notice: 'Cacheudni interface was successfully created.' }
        format.json { render :show, status: :created, location: @cacheudni_interface }
      else
        format.html { render :new }
        format.json { render json: @cacheudni_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cacheudni_interfaces/1
  # PATCH/PUT /cacheudni_interfaces/1.json
  def update
    respond_to do |format|
      if @cacheudni_interface.update(cacheudni_interface_params)
        format.html { redirect_to @cacheudni_interface, notice: 'Cacheudni interface was successfully updated.' }
        format.json { render :show, status: :ok, location: @cacheudni_interface }
      else
        format.html { render :edit }
        format.json { render json: @cacheudni_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cacheudni_interfaces/1
  # DELETE /cacheudni_interfaces/1.json
  def destroy
    @cacheudni_interface.destroy
    respond_to do |format|
      format.html { redirect_to cacheudni_interfaces_url, notice: 'Cacheudni interface was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cacheudni_interface
      @cacheudni_interface = CacheudniInterface.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cacheudni_interface_params
      params.require(:cacheudni_interface).permit(:device, :port, :nodo, :gbpsrx, :gbpstx, :bps_max, :status, :last_bps_max, :last_status, :crecimiento, :egressRate, :time, :comment, :deviceindex)
    end
end
