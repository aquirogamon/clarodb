class PpminterfacepreaggsController < ApplicationController

  def index
    @ppminterfacepreaggs = Ppminterfacepreagg.all
    unless Ppminterfacepreagg.last == nil
      @table_interfacepreagg = Ppminterfacepreagg.last[:ppminterfacepreaggs_array]
    end
    #rescue => e
    # flash[:error] = "Error de conexión con PPM"
    # redirect_to ppmreports_path
  end

  def show
    @ppminterfacepreagg = Ppminterfacepreagg.find(params[:ppminterfacepreagg][:id])
    rescue => e
     #flash[:error] = "Escoja un reporte válido."
     redirect_to ppmreports_ppminterfacepreaggs_path
  end

  def create
    @ppminterfacepreaggs = Ppminterfacepreagg.all
    @ppminterfacepreagg = Ppminterfacepreagg.create(:ppminterfacepreaggs_array => Ppminterfacepreagg.statsinterfacemax_table)
    if @ppminterfacepreagg.save
      @ppminterfacepreagg.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/ppmreports/ppminterfacepreaggs'
      if @ppminterfacepreaggs.count > 10
        @ppminterfacepreaggs.first.delete
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
