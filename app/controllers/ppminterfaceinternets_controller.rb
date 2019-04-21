class PpminterfaceinternetsController < ApplicationController

  def index
    @ppminterfaceinternets = Ppminterfaceinternet.all
    unless Ppminterfaceinternet.last == nil
      @table_interfaceinternet = Ppminterfaceinternet.last[:ppminterfaceinternets_array]
    end
    #rescue => e
    # flash[:error] = "Error de conexión con Prime Performance Manager"
    # redirect_to ppmreports_path
  end

  def show
    @ppminterfaceinternet = Ppminterfaceinternet.find(params[:ppminterfaceinternet][:id])
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to ppmreports_ppminterfaceinternets_path
  end

  def create
    @ppminterfaceinternets = Ppminterfaceinternet.all
    #@ppminterfaceinternet = Ppminterfaceinternet.create(:ppminterfaceinternets_array => Ppminterfaceinternet.interface_table_internet("internet"))
    @ppminterfaceinternet = Ppminterfaceinternet.create(:ppminterfaceinternets_array => Ppminterfaceinternet.statsinterfacecrecimiento_table)
    if @ppminterfaceinternet.save
      @ppminterfaceinternet.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/ppmreports/ppminterfaceinternets'
      if @ppminterfaceinternets.count > 20
        @ppminterfaceinternets.first.delete
      end
    else
      flash[:error] = "Error al actualizar el reporte."
      render :new
    end    
    #rescue => e
    # flash[:error] = "Error de conexión con Prime Performance Manager"
    # redirect_to ppmreports_path
  end

  def edit
    @table_interfaceinternet = Ppminterfaceinternet.last[:ppminterfaceinternets_array]
  end
  
  def update
    @table_interfaceinternet = Ppminterfaceinternet.last[:ppminterfaceinternets_array]
    @table_interfaceinternet.update
    #redirect_to ppmreports_ppminterfaceinternets_path
  end

end
