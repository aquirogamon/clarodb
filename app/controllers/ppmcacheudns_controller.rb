class PpmcacheudnsController < ApplicationController

  def index
    @ppmcacheudns = Ppmcacheudn.all
    unless Ppmcacheudn.last == nil
      @table_cacheudn = Ppmcacheudn.last[:ppmcacheudns_array]
    end
    #rescue => e
    # flash[:error] = "Error de conexión con PPM"
    # redirect_to ppmreports_path
  end

  def show
    @ppmcacheudn = Ppmcacheudn.find(params[:ppmcacheudn][:id])
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to ppmreportcaches_ppmcacheudns_path
  end

  def create
    @ppmcacheudns = Ppmcacheudn.all
    @ppmcacheudn = Ppmcacheudn.create(:ppmcacheudns_array => Ppmcacheudn.statsinterfacemax_table)
    if @ppmcacheudn.save
      @ppmcacheudn.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/ppmreportcaches/ppmcacheudns'
      if @ppmcacheudns.count > 20
        @ppmcacheudns.first.delete
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
