class SamgilatinterfacesController < ApplicationController

  def index
    @samgilatinterfaces = Samgilatinterface.all
    unless Samgilatinterface.last == nil
      @table_gilatinterface = Samgilatinterface.last[:samgilatinterfaces_array].paginate(:page => params[:page], :per_page => 500)
    end
    rescue => e
     flash[:error] = "Error de conexión con el SAM"
     redirect_to samqosdiscards_path
  end

  def show
    @samgilatinterface = Samgilatinterface.find(params[:samgilatinterface][:id])
    @table_gilatinterface_show = @samgilatinterface[:samgilatinterfaces_array].paginate(:page => params[:page], :per_page => 500)
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to samqosdiscards_samgilatinterfaces_path
  end

  def create
    @samgilatinterfaces = Samgilatinterface.all
    @samgilatinterface = Samgilatinterface.create(:samgilatinterfaces_array => Samgilatinterface.statsinterface_table)
    if @samgilatinterface.save
      @samgilatinterface.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/samqosdiscards/samgilatinterfaces'
      if @samgilatinterfaces.count > 20
        @samgilatinterfaces.first.delete
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
