class CoreInterfacesController < ApplicationController
  before_action :set_core_interface, only: [:show, :edit, :update, :destroy]

  # GET /core_interfaces
  # GET /core_interfaces.json
  def index
    @core_interfaces = CoreInterface.where(CoreInterface.arel_table[:created_at]
                                    .gt(CoreInterface.maximum(:created_at).to_date))
                                    .order("status DESC")
    @core_interfaces_all = CoreInterface.all

    respond_to do |format|
       format.html
       format.xls
       format.pdf do
         render :pdf => "Reporte Interfaces de Core - " + CoreInterface.last.created_at.strftime("%d/%m/%Y %H:%M:%S"),
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

  # GET /core_interfaces/1
  # GET /core_interfaces/1.json
  def show
  end

  # GET /core_interfaces/new
  def new
    @core_interface = CoreInterface.new
  end

  # GET /core_interfaces/1/edit
  def edit
  end

  # POST /core_interfaces
  # POST /core_interfaces.json
  def create
    @core_interface = CoreInterface.new(core_interface_params)

    respond_to do |format|
      if @core_interface.save
        format.html { redirect_to @core_interface, notice: 'Core interface was successfully created.' }
        format.json { render :show, status: :created, location: @core_interface }
      else
        format.html { render :new }
        format.json { render json: @core_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /core_interfaces/1
  # PATCH/PUT /core_interfaces/1.json
  def update
    respond_to do |format|
      if @core_interface.update(core_interface_params)
        format.html { redirect_to @core_interface, notice: 'Core interface was successfully updated.' }
        format.json { render :show, status: :ok, location: @core_interface }
      else
        format.html { render :edit }
        format.json { render json: @core_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /core_interfaces/1
  # DELETE /core_interfaces/1.json
  def destroy
    @core_interface.destroy
    respond_to do |format|
      format.html { redirect_to core_interfaces_url, notice: 'Core interface was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_core_interface
      @core_interface = CoreInterface.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def core_interface_params
      params.require(:core_interface).permit(:device, :port, :servicio, :gbpsrx, :gbpstx, :bps_max, :status, :last_bps_max, :last_status, :crecimiento, :egressRate, :time, :comment, :deviceindex)
    end
end
