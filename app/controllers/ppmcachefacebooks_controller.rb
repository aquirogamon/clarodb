class PpmcachefacebooksController < ApplicationController


  def index
    @ppmcachefacebooks = Ppmcachefacebook.all
    unless Ppmcachefacebook.last == nil
      @table_cachefacebook = Ppmcachefacebook.last[:ppmcachefacebooks_array]
    end
    #rescue => e
    # flash[:error] = "Error de conexión con PPM"
    # redirect_to ppmreports_path
  end

  def show
    @ppmcachefacebook = Ppmcachefacebook.find(params[:ppmcachefacebook][:id])
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to ppmreportcaches_ppmcachefacebooks_path
  end

  def create
    @ppmcachefacebooks = Ppmcachefacebook.all
    @ppmcachefacebook = Ppmcachefacebook.create(:ppmcachefacebooks_array => Ppmcachefacebook.statsinterfacemax_table)
    if @ppmcachefacebook.save
      @ppmcachefacebook.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/ppmreportcaches/ppmcachefacebooks'
      if @ppmcachefacebooks.count > 20
        @ppmcachefacebooks.first.delete
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
