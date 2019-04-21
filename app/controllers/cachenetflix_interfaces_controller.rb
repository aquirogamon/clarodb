class CachenetflixInterfacesController < ApplicationController
  before_action :set_cachenetflix_interface, only: [:show, :edit, :update, :destroy]

  # GET /cachenetflix_interfaces
  # GET /cachenetflix_interfaces.json
  def index
    @cachenetflix_interfaces = CachenetflixInterface.where(CachenetflixInterface.arel_table[:created_at]
                                    .gt(CachenetflixInterface.maximum(:created_at).to_date))
                                    .order("status DESC")
  end

  # GET /cachenetflix_interfaces/1
  # GET /cachenetflix_interfaces/1.json
  def show
  end

  # GET /cachenetflix_interfaces/new
  def new
    @cachenetflix_interface = CachenetflixInterface.new
  end

  # GET /cachenetflix_interfaces/1/edit
  def edit
  end

  # POST /cachenetflix_interfaces
  # POST /cachenetflix_interfaces.json
  def create
    @cachenetflix_interface = CachenetflixInterface.new(cachenetflix_interface_params)

    respond_to do |format|
      if @cachenetflix_interface.save
        format.html { redirect_to @cachenetflix_interface, notice: 'Cachenetflix interface was successfully created.' }
        format.json { render :show, status: :created, location: @cachenetflix_interface }
      else
        format.html { render :new }
        format.json { render json: @cachenetflix_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cachenetflix_interfaces/1
  # PATCH/PUT /cachenetflix_interfaces/1.json
  def update
    respond_to do |format|
      if @cachenetflix_interface.update(cachenetflix_interface_params)
        format.html { redirect_to @cachenetflix_interface, notice: 'Cachenetflix interface was successfully updated.' }
        format.json { render :show, status: :ok, location: @cachenetflix_interface }
      else
        format.html { render :edit }
        format.json { render json: @cachenetflix_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cachenetflix_interfaces/1
  # DELETE /cachenetflix_interfaces/1.json
  def destroy
    @cachenetflix_interface.destroy
    respond_to do |format|
      format.html { redirect_to cachenetflix_interfaces_url, notice: 'Cachenetflix interface was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cachenetflix_interface
      @cachenetflix_interface = CachenetflixInterface.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cachenetflix_interface_params
      params.require(:cachenetflix_interface).permit(:device, :port, :nodo, :gbpsrx, :gbpstx, :bps_max, :status, :last_bps_max, :last_status, :crecimiento, :egressRate, :time, :comment, :deviceindex)
    end
end
