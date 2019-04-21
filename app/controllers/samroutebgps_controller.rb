class SamroutebgpsController < ApplicationController

  def index
    @samroutebgps = Samroutebgp.all
    unless Samroutebgp.last == nil
      @table_routebgp = Samroutebgp.last[:samroutebgps_array]
    end
    rescue => e
     flash[:error] = "Error de conexión con el SAM"
     redirect_to samqosdiscards_path
  end

  def show
    @samroutebgp = Samroutebgp.find(params[:samroutebgp][:id])
    @table_routebgp_show = @samroutebgp[:samroutebgps_array]
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to samqosdiscards_samroutebgps_path
  end

  def create
    @samroutebgps = Samroutebgp.all
    @samroutebgp = Samroutebgp.create(:samroutebgps_array => Samroutebgp.samroutebgpfinal_table)
    if @samroutebgp.save
      @samroutebgp.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/samreportroutes/samroutebgps'
      if @samroutebgps.count > 20
        @samroutebgps.first.delete
      end
    else
      flash[:error] = "Error al actualizar el reporte"
      render :new
    end    
    #rescue => e
    # flash[:error] = "Error de conexión con SAM"
    # redirect_to samqosdiscards_path
  end

end
