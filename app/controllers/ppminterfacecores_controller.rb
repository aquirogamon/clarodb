class PpminterfacecoresController < ApplicationController

  def index
    @ppminterfacecores = Ppminterfacecore.all
    unless Ppminterfacecore.last == nil
      @table_interfaces = Ppminterfacecore.last[:ppminterfacecores_array]
    end
    rescue => e
     flash[:error] = "Error de conexión con Prime Performance Manager"
     redirect_to ppmreports_path
  end

  def show
    @ppminterfacecore = Ppminterfacecore.find(params[:ppminterfacecore][:id])
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to ppmreports_ppminterfaces_path
  end

  def create
    @ppminterfacecores = Ppminterfacecore.all
    @ppminterfacecore = Ppminterfacecore.create(:ppminterfacecores_array => Ppminterfacecore.interface_table_core("core"))
    if @ppminterfacecore.save
      @ppminterfacecore.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/ppmreports/ppminterfacecores'
      if @ppminterfacecores.count > 20
        @ppminterfacecores.first.delete
      end
    else
      flash[:error] = "Error al actualizar el reporte."
      render :new
    end    
    #rescue => e
    # flash[:error] = "Error de conexión con Prime Performance Manager"
    # redirect_to ppmreports_path
  end

end
