class CachefacebookInterfacesController < ApplicationController
  before_action :set_cachefacebook_interface, only: [:show, :edit, :update, :destroy]

  # GET /cachefacebook_interfaces
  # GET /cachefacebook_interfaces.json
  def index
    @cachefacebook_interfaces = CachefacebookInterface.where(CachefacebookInterface.arel_table[:created_at]
                                    .gt(CachefacebookInterface.maximum(:created_at).to_date))
                                    .order("status DESC")
  end

  # GET /cachefacebook_interfaces/1
  # GET /cachefacebook_interfaces/1.json
  def show
  end

  # GET /cachefacebook_interfaces/new
  def new
    @cachefacebook_interface = CachefacebookInterface.new
  end

  # GET /cachefacebook_interfaces/1/edit
  def edit
  end

  # POST /cachefacebook_interfaces
  # POST /cachefacebook_interfaces.json
  def create
    @cachefacebook_interface = CachefacebookInterface.new(cachefacebook_interface_params)

    respond_to do |format|
      if @cachefacebook_interface.save
        format.html { redirect_to @cachefacebook_interface, notice: 'Cachefacebook interface was successfully created.' }
        format.json { render :show, status: :created, location: @cachefacebook_interface }
      else
        format.html { render :new }
        format.json { render json: @cachefacebook_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cachefacebook_interfaces/1
  # PATCH/PUT /cachefacebook_interfaces/1.json
  def update
    respond_to do |format|
      if @cachefacebook_interface.update(cachefacebook_interface_params)
        format.html { redirect_to @cachefacebook_interface, notice: 'Cachefacebook interface was successfully updated.' }
        format.json { render :show, status: :ok, location: @cachefacebook_interface }
      else
        format.html { render :edit }
        format.json { render json: @cachefacebook_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cachefacebook_interfaces/1
  # DELETE /cachefacebook_interfaces/1.json
  def destroy
    @cachefacebook_interface.destroy
    respond_to do |format|
      format.html { redirect_to cachefacebook_interfaces_url, notice: 'Cachefacebook interface was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cachefacebook_interface
      @cachefacebook_interface = CachefacebookInterface.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cachefacebook_interface_params
      params.require(:cachefacebook_interface).permit(:device, :port, :nodo, :gbpsrx, :gbpstx, :bps_max, :status, :last_bps_max, :last_status, :crecimiento, :egressRate, :time, :comment, :deviceindex)
    end
end
