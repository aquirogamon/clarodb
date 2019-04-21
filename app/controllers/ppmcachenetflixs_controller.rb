class PpmcachenetflixsController < ApplicationController


  def index
    @ppmcachenetflixs = Ppmcachenetflix.all
    unless Ppmcachenetflix.last == nil
      @table_cachenetflix = Ppmcachenetflix.last[:ppmcachenetflixs_array]
    end
    #rescue => e
    # flash[:error] = "Error de conexión con PPM"
    # redirect_to ppmreports_path
  end

  def show
    @ppmcachenetflix = Ppmcachenetflix.find(params[:ppmcachenetflix][:id])
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to ppmreportcaches_ppmcachenetflixs_path
  end

  def create
    @ppmcachenetflixs = Ppmcachenetflix.all
    @ppmcachenetflix = Ppmcachenetflix.create(:ppmcachenetflixs_array => Ppmcachenetflix.statsinterfacemax_table)
    if @ppmcachenetflix.save
      @ppmcachenetflix.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/ppmreportcaches/ppmcachenetflixs'
      if @ppmcachenetflixs.count > 20
        @ppmcachenetflixs.first.delete
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
