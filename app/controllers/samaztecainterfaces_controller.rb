class SamaztecainterfacesController < ApplicationController

  def index
    @samaztecainterfaces = Samaztecainterface.all
    unless Samaztecainterface.last == nil
      @table_aztecainterface = Samaztecainterface.last[:samaztecainterfaces_array].paginate(:page => params[:page], :per_page => 500)
    end
    rescue => e
     flash[:error] = "Error de conexión con el SAM"
     redirect_to samqosdiscards_path
  end

  def show
    @samaztecainterface = Samaztecainterface.find(params[:samaztecainterface][:id])
    @table_aztecainterface_show = @samaztecainterface[:samaztecainterfaces_array].paginate(:page => params[:page], :per_page => 500)
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to samqosdiscards_samaztecainterfaces_path
  end

  def create
    @samaztecainterfaces = Samaztecainterface.all
    @samaztecainterface = Samaztecainterface.create(:samaztecainterfaces_array => Samaztecainterface.statsinterface_table)
    if @samaztecainterface.save
      @samaztecainterface.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/samqosdiscards/samaztecainterfaces'
      if @samaztecainterfaces.count > 20
        @samaztecainterfaces.first.delete
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