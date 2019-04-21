class PpminterfaceclientinternetsController < ApplicationController

  def index
    @ppminterfaceclientinternets = Ppminterfaceclientinternet.all
    unless Ppminterfaceclientinternet.last == nil
      @table_interfaceclientinternet = Ppminterfaceclientinternet.last[:ppminterfaceclientinternets_array]
    end
    respond_to do |format|
       format.html
       format.xls
       #format.pdf do
       #  render :pdf => "Reporte Internet Corporativo", :encoding => "UTF-8", :type=>"application/pdf"
       #end
       format.pdf do
         render :pdf => "Reporte Internet Corporativo - " + Ppminterfaceclientinternet.last.created_at.strftime("%d/%m/%Y %H:%M:%S"),
         :layout => 'pdf.html',
         #:margin => {:top => 10, :bottom => 10, :left => 10, :right => 10},
         :orientation => 'Landscape', # default , Landscape,
         :background => true,
         :encoding => "UTF-8", :type=>"application/pdf",
         #:javascript_delay => 10000,
         #:disposition => "attachment",
         :viewport_size => "1280x1024",
         :page_size => "A4",
         :footer => { :right => 'Page [page] of [topage]',:font_size => 7 }
       end
    end
    #rescue => e
    # flash[:error] = "Error de conexión con PPM"
    # redirect_to ppmreports_path
  end

  def show
    @ppminterfaceclientinternet = Ppminterfaceclientinternet.find(params[:ppminterfaceclientinternet][:id])
    rescue => e
     #flash[:error] = "Escoja un reporte válido."
     redirect_to ppmreports_ppminterfaceclientinternets_path
  end

  def create
    @ppminterfaceclientinternets = Ppminterfaceclientinternet.all
    @ppminterfaceclientinternet = Ppminterfaceclientinternet.create(:ppminterfaceclientinternets_array => Ppminterfaceclientinternet.statsinterfacecrecimiento_table)
    if @ppminterfaceclientinternet.save
      @ppminterfaceclientinternet.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/ppmreports/ppminterfaceclientinternets'
      if @ppminterfaceclientinternets.count > 10
        @ppminterfaceclientinternets.first.delete
      end
    else
      flash[:error] = "Error al actualizar el reporte."
      render :new
    end    
    #rescue => e
    # flash[:error] = "Error de conexión con ppm"
    # redirect_to ppmreports_path
  end
  
end
