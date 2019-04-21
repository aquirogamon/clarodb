class SamenvironmentsController < ApplicationController

  def index
    @samenvironments = Samenvironment.all
    unless Samenvironment.last == nil
      @table_environment = Samenvironment.last[:samenvironments_array]
    end
    rescue => e
     flash[:error] = "Error de conexión con el SAM"
     redirect_to samreports_path
  end

  def show
    @samenvironment = Samenvironment.find(params[:samenvironment][:id])
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to samreports_samenvironments_path
  end

  def create
    @samenvironments = Samenvironment.all
    @samenvironment = Samenvironment.create(:samenvironments_array => Samenvironment.samenvironment_table)
    if @samenvironment.save
      @samenvironment.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/samreports/samenvironments'
      if @samenvironments.count > 10
        @samenvironments.first.delete
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