class SammemosController < ApplicationController

  def index
    @sammemos = Sammemo.all
    unless Sammemo.last == nil
      @table_memory = Sammemo.last[:sammemos_array]
    end
    rescue => e
     flash[:error] = "Error de conexión con el SAM"
     redirect_to samreports_path
  end

  def show
    @sammemo = Sammemo.find(params[:sammemo][:id])
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to samreports_sammemories_path
  end

  def create
    @sammemos = Sammemo.all
    @sammemo = Sammemo.create(:sammemos_array => Sammemo.memory_table)
    if @sammemo.save
      @sammemo.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/samreports/sammemos'
      if @sammemos.count > 10
        @sammemos.first.delete
      end
    else
      flash[:error] = "Error al actualizar el reporte."
      render :new
    end    
    #rescue => e
    # flash[:error] = "Error de conexión con SAM"
    # redirect_to samreports_path
  end

end