class PpmcachegooglesController < ApplicationController

  def index
    @ppmcachegoogles = Ppmcachegoogle.all
    unless Ppmcachegoogle.last == nil
      @table_cachegoogle = Ppmcachegoogle.last[:ppmcachegoogles_array]
    end
    #rescue => e
    # flash[:error] = "Error de conexión con PPM"
    # redirect_to ppmreports_path
  end

  def show
    @ppmcachegoogle = Ppmcachegoogle.find(params[:ppmcachegoogle][:id])
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to ppmreportcaches_ppmcachegoogles_path
  end

  def create
    @ppmcachegoogles = Ppmcachegoogle.all
    @ppmcachegoogle = Ppmcachegoogle.create(:ppmcachegoogles_array => Ppmcachegoogle.statsinterfacemax_table)
    if @ppmcachegoogle.save
      @ppmcachegoogle.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/ppmreportcaches/ppmcachegoogles'
      if @ppmcachegoogles.count > 20
        @ppmcachegoogles.first.delete
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
