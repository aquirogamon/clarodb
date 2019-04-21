class CachegoogleInterfacesController < ApplicationController
  before_action :set_cachegoogle_interface, only: [:show, :edit, :update, :destroy]

  # GET /cachegoogle_interfaces
  # GET /cachegoogle_interfaces.json
  def index
    @cachegoogle_interfaces = CachegoogleInterface.where(CachegoogleInterface.arel_table[:created_at]
                                    .gt(CachegoogleInterface.maximum(:created_at).to_date))
                                    .order("status DESC")
  end

  # GET /cachegoogle_interfaces/1
  # GET /cachegoogle_interfaces/1.json
  def show
  end

  # GET /cachegoogle_interfaces/new
  def new
    @cachegoogle_interface = CachegoogleInterface.new
  end

  # GET /cachegoogle_interfaces/1/edit
  def edit
  end

  # POST /cachegoogle_interfaces
  # POST /cachegoogle_interfaces.json
  def create
    @cachegoogle_interface = CachegoogleInterface.new(cachegoogle_interface_params)

    respond_to do |format|
      if @cachegoogle_interface.save
        format.html { redirect_to @cachegoogle_interface, notice: 'Cachegoogle interface was successfully created.' }
        format.json { render :show, status: :created, location: @cachegoogle_interface }
      else
        format.html { render :new }
        format.json { render json: @cachegoogle_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cachegoogle_interfaces/1
  # PATCH/PUT /cachegoogle_interfaces/1.json
  def update
    respond_to do |format|
      if @cachegoogle_interface.update(cachegoogle_interface_params)
        format.html { redirect_to @cachegoogle_interface, notice: 'Cachegoogle interface was successfully updated.' }
        format.json { render :show, status: :ok, location: @cachegoogle_interface }
      else
        format.html { render :edit }
        format.json { render json: @cachegoogle_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cachegoogle_interfaces/1
  # DELETE /cachegoogle_interfaces/1.json
  def destroy
    @cachegoogle_interface.destroy
    respond_to do |format|
      format.html { redirect_to cachegoogle_interfaces_url, notice: 'Cachegoogle interface was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cachegoogle_interface
      @cachegoogle_interface = CachegoogleInterface.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cachegoogle_interface_params
      params.require(:cachegoogle_interface).permit(:device, :port, :nodo, :gbpsrx, :gbpstx, :bps_max, :status, :last_bps_max, :last_status, :crecimiento, :egressRate, :time, :comment, :deviceindex)
    end
end
