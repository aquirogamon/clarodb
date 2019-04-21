class PpmredcorporativainterfacesController < ApplicationController

  def index
    @ppmredcorporativainterfaces = Ppmredcorporativainterface.all
    unless Ppmredcorporativainterface.last == nil
      @table_redcorporativainterface = Ppmredcorporativainterface.last[:ppmredcorporativainterfaces_array]
    end
    #rescue => e
    # flash[:error] = "Error de conexión con Prime Performance Manager"
    # redirect_to ppmreports_path
    respond_to do |format|
       format.html
       format.xls
       format.pdf do
         render :pdf => "Reporte de Red Corporativa - " + Ppmredcorporativainterface.last.created_at.strftime("%d/%m/%Y %H:%M:%S"),
         :layout => 'pdf.html',
         #:margin => {:top => 10, :bottom => 10, :left => 10, :right => 10},
         :orientation => 'Landscape', # default , Landscape,
         :background => true,
         :encoding => "UTF-8", :type=>"application/pdf",
         #:javascript_delay => 10000,
         :disposition => "attachment",
         :viewport_size => "1280x1024",
         :page_size => "A4",
         :footer => { :right => 'Page [page] of [topage]',:font_size => 7 }
       end
    end
  end

  def show
    @ppmredcorporativainterface = Ppmredcorporativainterface.find(params[:ppmredcorporativainterface][:id])
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to ppmreports_ppmredcorporativainterfaces_path
  end

  def create
    @ppmredcorporativainterfaces = Ppmredcorporativainterface.all
    #@ppminterfaceclientinternet = Ppminterfaceclientinternet.create(:ppminterfaceclientinternets_array => Ppminterfaceclientinternet.statsinterfacemax_table)
    @ppmredcorporativainterface = Ppmredcorporativainterface.create(:ppmredcorporativainterfaces_array => Ppmredcorporativainterface.statsinterfacecrecimiento_table)
    if @ppmredcorporativainterface.save
      @ppmredcorporativainterface.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/ppmreports/ppmredcorporativainterfaces'
      if @ppmredcorporativainterfaces.count > 20
        @ppmredcorporativainterfaces.first.delete
      end
    else
      flash[:error] = "Error al actualizar el reporte."
      render :new
    end    
    #rescue => e
    # flash[:error] = "Error de conexión con Prime Performance Manager"
    # redirect_to ppmreports_path
  end
  
end
