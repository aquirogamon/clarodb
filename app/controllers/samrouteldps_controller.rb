class SamrouteldpsController < ApplicationController

  def index
    @samrouteldps = Samrouteldp.all
    unless Samrouteldp.last == nil
      @table_routeldp = Samrouteldp.last[:samrouteldps_array].paginate(:page => params[:page], :per_page => 500)
    end
    rescue => e
     flash[:error] = "Error de conexión con el SAM"
     redirect_to samqosdiscards_path
  end

  def show
    @samrouteldp = Samrouteldp.find(params[:samrouteldp][:id])
    @table_routeldp_show = @samrouteldp[:samrouteldps_array].paginate(:page => params[:page], :per_page => 500)
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to samqosdiscards_samrouteldps_path
  end

  def create
    @samrouteldps = Samrouteldp.all
    @samrouteldp = Samrouteldp.create(:samrouteldps_array => Samrouteldp.samrouteldpfinal_table)
    if @samrouteldp.save
      @samrouteldp.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/samreportroutes/samrouteldps'
      if @samrouteldps.count > 20
        @samrouteldps.first.delete
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