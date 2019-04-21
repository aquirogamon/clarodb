class SamutilizationaccesointerfacesController < ApplicationController

  def index
    @samutilizationaccesointerfaces = Samutilizationaccesointerface.all
    unless Samutilizationaccesointerface.last == nil
      @table_utilizationaccesointerface = Samutilizationaccesointerface.last[:samutilizationaccesointerfaces_array]
    end
    rescue => e
     flash[:error] = "Error de conexión con el SAM"
     redirect_to samqosdiscards_path
  end

  def show
    @samutilizationaccesointerface = Samutilizationaccesointerface.find(params[:samutilizationaccesointerface][:id])
    @table_utilizationaccesointerface_show = @samutilizationaccesointerface[:samutilizationaccesointerfaces_array]
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to samqosdiscards_samutilizationaccesointerfaces_path
  end

  def create
    @samutilizationaccesointerfaces = Samutilizationaccesointerface.all
    @samutilizationaccesointerface = Samutilizationaccesointerface.create(:samutilizationaccesointerfaces_array => Samutilizationaccesointerface.statsinterface_table)
    if @samutilizationaccesointerface.save
      @samutilizationaccesointerface.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/samqosdiscards/samutilizationaccesointerfaces'
      if @samutilizationaccesointerfaces.count > 20
        @samutilizationaccesointerfaces.first.delete
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