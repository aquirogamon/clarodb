class SamutilizationmwinterfacesController < ApplicationController

  def index
    @samutilizationmwinterfaces = Samutilizationmwinterface.all
    unless Samutilizationmwinterface.last == nil
      @table_utilizationmwinterface = Samutilizationmwinterface.last[:samutilizationmwinterfaces_array].paginate(:page => params[:page], :per_page => 1500)
    end
    rescue => e
     flash[:error] = "Error de conexión con el SAM"
     redirect_to samqosdiscards_path
  end

  def show
    @samutilizationmwinterface = Samutilizationmwinterface.find(params[:samutilizationmwinterface][:id])
    @table_utilizationmwinterface_show = @samutilizationmwinterface[:samutilizationmwinterfaces_array].paginate(:page => params[:page], :per_page => 1500)
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to samqosdiscards_samutilizationmwinterfaces_path
  end

  def create
    @samutilizationmwinterfaces = Samutilizationmwinterface.all
    @samutilizationmwinterface = Samutilizationmwinterface.create(:samutilizationmwinterfaces_array => Samutilizationmwinterface.statsinterface_table)
    if @samutilizationmwinterface.save
      @samutilizationmwinterface.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/samqosdiscards/samutilizationmwinterfaces'
      if @samutilizationmwinterfaces.count > 20
        @samutilizationmwinterfaces.first.delete
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
