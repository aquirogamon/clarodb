class RedcorporativaInterfacesController < ApplicationController
  before_action :set_redcorporativa_interface, only: [:show, :edit, :update, :destroy]

  # GET /redcorporativa_interfaces
  # GET /redcorporativa_interfaces.json
  def index
    @redcorporativa_interfaces = RedcorporativaInterface.where(RedcorporativaInterface.arel_table[:created_at]
                                    .gt(RedcorporativaInterface.maximum(:created_at).to_date))
                                    .order("status DESC")
  end

  # GET /redcorporativa_interfaces/1
  # GET /redcorporativa_interfaces/1.json
  def show
  end

  # GET /redcorporativa_interfaces/new
  def new
    @redcorporativa_interface = RedcorporativaInterface.new
  end

  # GET /redcorporativa_interfaces/1/edit
  def edit
  end

  # POST /redcorporativa_interfaces
  # POST /redcorporativa_interfaces.json
  def create
    @redcorporativa_interface = RedcorporativaInterface.new(redcorporativa_interface_params)

    respond_to do |format|
      if @redcorporativa_interface.save
        format.html { redirect_to @redcorporativa_interface, notice: 'Redcorporativa interface was successfully created.' }
        format.json { render :show, status: :created, location: @redcorporativa_interface }
      else
        format.html { render :new }
        format.json { render json: @redcorporativa_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /redcorporativa_interfaces/1
  # PATCH/PUT /redcorporativa_interfaces/1.json
  def update
    respond_to do |format|
      if @redcorporativa_interface.update(redcorporativa_interface_params)
        format.html { redirect_to @redcorporativa_interface, notice: 'Redcorporativa interface was successfully updated.' }
        format.json { render :show, status: :ok, location: @redcorporativa_interface }
      else
        format.html { render :edit }
        format.json { render json: @redcorporativa_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /redcorporativa_interfaces/1
  # DELETE /redcorporativa_interfaces/1.json
  def destroy
    @redcorporativa_interface.destroy
    respond_to do |format|
      format.html { redirect_to redcorporativa_interfaces_url, notice: 'Redcorporativa interface was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_redcorporativa_interface
      @redcorporativa_interface = RedcorporativaInterface.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def redcorporativa_interface_params
      params.require(:redcorporativa_interface).permit(:device, :port, :servicio, :gbpsrx, :gbpstx, :bps_max, :statustx, :statusrx, :status, :last_bps_max, :last_status, :crecimiento_rx, :crecimiento_tx, :egressRate, :time, :comment, :deviceindex)
    end
end
