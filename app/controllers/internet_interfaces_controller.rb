class InternetInterfacesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_internet_interface, only: [:show, :edit, :update, :destroy, :traffic_internetinterfaces]

  # GET /internet_interfaces
  # GET /internet_interfaces.json
  def index
    @internet_interfaces = InternetInterface.where(InternetInterface.arel_table[:created_at].gt(InternetInterface.maximum(:created_at).to_date)).order("status DESC")
    @internet_interfaces_all = InternetInterface.all

    respond_to do |format|
       format.html
       format.xls
       format.pdf do
         render :pdf => "(Reporte de Interfaces de Internet Semana \##{InternetInterface.maximum(:created_at).strftime("%U - %Y")})",
         :layout => 'pdf.html',
         :margin => {:top => 10, :bottom => 10, :left => 10, :right => 10},
         :orientation => 'landscape', # default , Landscape,
         :background => true,
         :encoding => "UTF-8", :type=>"application/pdf",
         :javascript_delay => 10000,
         #:disposition => "attachment",
         :viewport_size => "1280x1024",
         :page_size => "A4",
         :footer => { :right => 'Page [page] of [topage]',:font_size => 7 }
       end
    end
  end

  # GET /internet_interfaces/1
  # GET /internet_interfaces/1.json
  def show
  end

  # GET /internet_interfaces/new
  def new
    @internet_interface = InternetInterface.new
  end

  # GET /internet_interfaces/1/edit
  def edit
  end

  # POST /internet_interfaces
  # POST /internet_interfaces.json
  def create
    @internet_interface = InternetInterface.new(internet_interface_params)

    respond_to do |format|
      if @internet_interface.save
        format.html { redirect_to @internet_interface, notice: 'Internet interface was successfully created.' }
        format.json { render :show, status: :created, location: @internet_interface }
      else
        format.html { render :new }
        format.json { render json: @internet_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /internet_interfaces/1
  # PATCH/PUT /internet_interfaces/1.json
  def update
    respond_to do |format|
      if @internet_interface.update(internet_interface_params)
        format.html { redirect_to @internet_interface, notice: 'Internet interface was successfully updated.' }
        format.json { render :show, status: :ok, location: @internet_interface }
      else
        format.html { render :edit }
        format.json { render json: @internet_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /internet_interfaces/1
  # DELETE /internet_interfaces/1.json
  def destroy
    @internet_interface.destroy
    respond_to do |format|
      format.html { redirect_to internet_interfaces_url, notice: 'Internet interface was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_internet_interface
      @internet_interface = InternetInterface.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def internet_interface_params
      params.require(:internet_interface).permit(:device, :port, :servicio, :gbpsrx, :gbpstx, :bps_max, :last_bps_max, :last_status, :crecimiento, :status, :egressRate, :neighbor, :time, :comment, :deviceindex)
    end
end
