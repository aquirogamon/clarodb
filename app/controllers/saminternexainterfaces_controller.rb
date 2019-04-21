class SaminternexainterfacesController < ApplicationController

  def index
    @saminternexainterfaces = Saminternexainterface.all
    unless Saminternexainterface.last == nil
      @table_internexainterface = Saminternexainterface.last[:saminternexainterfaces_array].paginate(:page => params[:page], :per_page => 500)
    end
    rescue => e
     flash[:error] = "Error de conexión con el SAM"
     redirect_to samqosdiscards_path
  end

  def show
    @saminternexainterface = Saminternexainterface.find(params[:saminternexainterface][:id])
    @table_internexainterface_show = @saminternexainterface[:saminternexainterfaces_array].paginate(:page => params[:page], :per_page => 500)
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to samqosdiscards_saminternexainterfaces_path
  end

  def create
    @saminternexainterfaces = Saminternexainterface.all
    @saminternexainterface = Saminternexainterface.create(:saminternexainterfaces_array => Saminternexainterface.statsinterface_table)
    if @saminternexainterface.save
      @saminternexainterface.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/samqosdiscards/saminternexainterfaces'
      if @saminternexainterfaces.count > 20
        @saminternexainterfaces.first.delete
      end
    else
      flash[:error] = "Error al actualizar el reporte."
      render :new
    end    
    #rescue => e
    # flash[:error] = "Error de conexión con SAM"
    # redirect_to samqosdiscards_path
  end
  
end
