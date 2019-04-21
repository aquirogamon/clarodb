class IpranaccessInterfacesController < ApplicationController
  before_action :set_ipranaccess_interface, only: [:show, :edit, :update, :destroy]

  # GET /ipranaccess_interfaces
  # GET /ipranaccess_interfaces.json
  def index
    @ipranaccess_interfaces = IpranaccessInterface.where(IpranaccessInterface.arel_table[:created_at].gt(IpranaccessInterface.maximum(:created_at).to_date)).order("status DESC").paginate(:page => params[:page], :per_page => 1000)

    respond_to do |format|
       format.html
       format.xls
       format.pdf do
         render :pdf => "Reporte Interfaces de IPRAN Acceso - " + IpranaccessInterface.last.created_at.strftime("%d/%m/%Y %H:%M:%S"),
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

  # GET /ipranaccess_interfaces/1
  # GET /ipranaccess_interfaces/1.json
  def show
  end

  # GET /ipranaccess_interfaces/new
  def new
    @ipranaccess_interface = IpranaccessInterface.new
  end

  # GET /ipranaccess_interfaces/1/edit
  def edit
  end

  # POST /ipranaccess_interfaces
  # POST /ipranaccess_interfaces.json
  def create
    @ipranaccess_interface = IpranaccessInterface.new(ipranaccess_interface_params)

    respond_to do |format|
      if @ipranaccess_interface.save
        format.html { redirect_to @ipranaccess_interface, notice: 'Ipranaccess interface was successfully created.' }
        format.json { render :show, status: :created, location: @ipranaccess_interface }
      else
        format.html { render :new }
        format.json { render json: @ipranaccess_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ipranaccess_interfaces/1
  # PATCH/PUT /ipranaccess_interfaces/1.json
  def update
    respond_to do |format|
      if @ipranaccess_interface.update(ipranaccess_interface_params)
        format.html { redirect_to @ipranaccess_interface, notice: 'Ipranaccess interface was successfully updated.' }
        format.json { render :show, status: :ok, location: @ipranaccess_interface }
      else
        format.html { render :edit }
        format.json { render json: @ipranaccess_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ipranaccess_interfaces/1
  # DELETE /ipranaccess_interfaces/1.json
  def destroy
    @ipranaccess_interface.destroy
    respond_to do |format|
      format.html { redirect_to ipranaccess_interfaces_url, notice: 'Ipranaccess interface was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ipranaccess_interface
      @ipranaccess_interface = IpranaccessInterface.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ipranaccess_interface_params
      params.require(:ipranaccess_interface).permit(:device, :port, :description, :egressRate, :speed, :gbpsrx, :gbpstx, :last_bps_max, :last_status, :bps_max, :status, :crecimiento, :time, :comment, :deviceindex)
    end
end
