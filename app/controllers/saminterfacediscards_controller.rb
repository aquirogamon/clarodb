class SaminterfacediscardsController < ApplicationController

  def index
    @saminterfacediscards = Saminterfacediscard.all
    unless Saminterfacediscard.last == nil
      @table_interfacediscard = Saminterfacediscard.last[:saminterfacediscards_array].paginate(:page => params[:page], :per_page => 500)
    end
    rescue => e
     flash[:error] = "Error de conexión con el SAM"
     redirect_to samqosdiscards_path
  end

  def show
    @saminterfacediscard = Saminterfacediscard.find(params[:saminterfacediscard][:id])
    @table_interfacediscard_show = @saminterfacediscard[:saminterfacediscards_array].paginate(:page => params[:page], :per_page => 500)
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to samqosdiscards_saminterfacediscards_path
  end

  def create
    @saminterfacediscards = Saminterfacediscard.all
    @saminterfacediscard = Saminterfacediscard.create(:saminterfacediscards_array => Saminterfacediscard.saminterfacediscard_table)
    if @saminterfacediscard.save
      @saminterfacediscard.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/samqosdiscards/saminterfacediscards'
      if @saminterfacediscards.count > 20
        @saminterfacediscards.first.delete
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