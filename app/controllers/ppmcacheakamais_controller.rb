class PpmcacheakamaisController < ApplicationController

  def index
    @ppmcacheakamais = Ppmcacheakamai.all
    unless Ppmcacheakamai.last == nil
      @table_cacheakamai = Ppmcacheakamai.last[:ppmcacheakamais_array]
    end
    #rescue => e
    # flash[:error] = "Error de conexión con PPM"
    # redirect_to ppmreports_path
    respond_to do |format|
      format.html
      format.xls
    end
  end

  def show
    @ppmcacheakamai = Ppmcacheakamai.find(params[:ppmcacheakamai][:id])
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to ppmreportcaches_ppmcacheakamais_path
  end

  def create
    @ppmcacheakamais = Ppmcacheakamai.all
    @ppmcacheakamai = Ppmcacheakamai.create(:ppmcacheakamais_array => Ppmcacheakamai.statsinterfacemax_table)
    if @ppmcacheakamai.save
      @ppmcacheakamai.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/ppmreportcaches/ppmcacheakamais'
      if @ppmcacheakamais.count > 20
        @ppmcacheakamais.first.delete
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