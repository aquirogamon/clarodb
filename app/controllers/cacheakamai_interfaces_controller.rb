class CacheakamaiInterfacesController < ApplicationController
  before_action :set_cacheakamai_interface, only: [:show, :edit, :update, :destroy]

  # GET /cacheakamai_interfaces
  # GET /cacheakamai_interfaces.json
  def index
    @cacheakamai_interfaces = CacheakamaiInterface.where(CacheakamaiInterface.arel_table[:created_at]
                                    .gt(CacheakamaiInterface.maximum(:created_at).to_date))
                                    .order("status DESC")
  end

  # GET /cacheakamai_interfaces/1
  # GET /cacheakamai_interfaces/1.json
  def show
  end

  # GET /cacheakamai_interfaces/new
  def new
    @cacheakamai_interface = CacheakamaiInterface.new
  end

  # GET /cacheakamai_interfaces/1/edit
  def edit
  end

  # POST /cacheakamai_interfaces
  # POST /cacheakamai_interfaces.json
  def create
    @cacheakamai_interface = CacheakamaiInterface.new(cacheakamai_interface_params)

    respond_to do |format|
      if @cacheakamai_interface.save
        format.html { redirect_to @cacheakamai_interface, notice: 'Cacheakamai interface was successfully created.' }
        format.json { render :show, status: :created, location: @cacheakamai_interface }
      else
        format.html { render :new }
        format.json { render json: @cacheakamai_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cacheakamai_interfaces/1
  # PATCH/PUT /cacheakamai_interfaces/1.json
  def update
    respond_to do |format|
      if @cacheakamai_interface.update(cacheakamai_interface_params)
        format.html { redirect_to @cacheakamai_interface, notice: 'Cacheakamai interface was successfully updated.' }
        format.json { render :show, status: :ok, location: @cacheakamai_interface }
      else
        format.html { render :edit }
        format.json { render json: @cacheakamai_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cacheakamai_interfaces/1
  # DELETE /cacheakamai_interfaces/1.json
  def destroy
    @cacheakamai_interface.destroy
    respond_to do |format|
      format.html { redirect_to cacheakamai_interfaces_url, notice: 'Cacheakamai interface was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cacheakamai_interface
      @cacheakamai_interface = CacheakamaiInterface.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cacheakamai_interface_params
      params.require(:cacheakamai_interface).permit(:device, :port, :nodo, :gbpsrx, :gbpstx, :bps_max, :status, :last_bps_max, :last_status, :crecimiento, :egressRate, :time, :comment, :deviceindex)
    end
end
