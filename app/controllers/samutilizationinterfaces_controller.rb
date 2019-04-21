class SamutilizationinterfacesController < ApplicationController

  def index
    @samutilizationinterfaces = Samutilizationinterface.all
    unless Samutilizationinterface.last == nil
      @table_utilizationinterface = Samutilizationinterface.last[:samutilizationinterfaces_array]
    end
    rescue => e
     flash[:error] = "Error de conexión con el SAM"
     redirect_to samqosdiscards_path
  end

  def show
    @samutilizationinterface = Samutilizationinterface.find(params[:samutilizationinterface][:id])
    @table_utilizationinterface_show = @samutilizationinterface[:samutilizationinterfaces_array]
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to samqosdiscards_samutilizationinterfaces_path
  end

  def create
    @samutilizationinterfaces = Samutilizationinterface.all
    @samutilizationinterface = Samutilizationinterface.create(:samutilizationinterfaces_array => Samutilizationinterface.statsinterface_table)
    if @samutilizationinterface.save
      @samutilizationinterface.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/samqosdiscards/samutilizationinterfaces'
      if @samutilizationinterfaces.count > 20
        @samutilizationinterfaces.first.delete
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