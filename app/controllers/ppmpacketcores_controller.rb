class PpmpacketcoresController < ApplicationController

  def index
    @ppmpacketcores = Ppmpacketcore.all
    unless Ppmpacketcore.last == nil
      @table_packetcore = Ppmpacketcore.last[:ppmpacketcores_array]
    end
    #rescue => e
    # flash[:error] = "Error de conexión con PPM"
    # redirect_to ppmreports_path
  end

  def show
    @ppmpacketcore = Ppmpacketcore.find(params[:ppmpacketcore][:id])
    rescue => e
     #flash[:error] = "Escoja un reporte válido."
     redirect_to ppmreports_ppmpacketcores_path
  end

  def create
    @ppmpacketcores = Ppmpacketcore.all
    @ppmpacketcore = Ppmpacketcore.create(:ppmpacketcores_array => Ppmpacketcore.statsinterfacemax_table)
    if @ppmpacketcore.save
      @ppmpacketcore.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/ppmreports/ppmpacketcores'
      if @ppmpacketcores.count > 10
        @ppmpacketcores.first.delete
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
