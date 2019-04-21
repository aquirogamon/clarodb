class SessionAccediansController < ApplicationController
  before_action :set_session_accedian, only: [:show, :edit, :update, :destroy]

  # GET /session_accedians
  # GET /session_accedians.json
  def index
    @session_accedians = SessionAccedian.all.paginate(:page => params[:page], :per_page => 2000)
    @session_accedians_all = SessionAccedian.all
  end

  # GET /session_accedians/1
  # GET /session_accedians/1.json
  def show
    SessionAccedian.id_session_detail(params[:id])
  end

  # GET /session_accedians/new
  def new
    @session_accedian = SessionAccedian.new
  end

  # GET /session_accedians/1/edit
  def edit
  end

  # POST /session_accedians
  # POST /session_accedians.json
  def create
    @session_accedian = SessionAccedian.create(SessionAccedian.all_sessions_endpoint)
  end

  # PATCH/PUT /session_accedians/1
  # PATCH/PUT /session_accedians/1.json
  def update
    respond_to do |format|
      if @session_accedian.update(session_accedian_params)
        format.html { redirect_to @session_accedian, notice: 'Session accedian was successfully updated.' }
        format.json { render :show, status: :ok, location: @session_accedian }
      else
        format.html { render :edit }
        format.json { render json: @session_accedian.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /session_accedians/1
  # DELETE /session_accedians/1.json
  def destroy
    @session_accedian.destroy
    respond_to do |format|
      format.html { redirect_to session_accedians_url, notice: 'Session accedian was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session_accedian
      @session_accedian = SessionAccedian.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def session_accedian_params
      params.require(:session_accedian).permit(:ip_endpoint, :name_endpoint, :product_endpoint, :state_endpoint, :type_endpoint, :capability, :port_endpoint, :tos_endpoint, :name_session, :sessionType, :sid, :dstEndpoint, :dstPort, :srcEndpoint, :srcIfc, :srcPort, :state_session, :interval_session, :tos_session, :payloadsize_session, :pps_session, :type_port, :sla, :status_device, :ip_interface_vcx)
    end
end
