class SamrouteospfsController < ApplicationController

  def index
    @samrouteospfs = Samrouteospf.all
    unless Samrouteospf.last == nil
      @table_routeospf = Samrouteospf.last[:samrouteospfs_array].paginate(:page => params[:page], :per_page => 500)
    end
    rescue => e
     flash[:error] = "Error de conexión con el SAM"
     redirect_to samqosdiscards_path
  end

  def show
    @samrouteospf = Samrouteospf.find(params[:samrouteospf][:id])
    @table_routeospf_show = @samrouteospf[:samrouteospfs_array].paginate(:page => params[:page], :per_page => 500)
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to samqosdiscards_samrouteospfs_path
  end

  def create
    @samrouteospfs = Samrouteospf.all
    @samrouteospf = Samrouteospf.create(:samrouteospfs_array => Samrouteospf.samrouteospf_table)
    if @samrouteospf.save
      @samrouteospf.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/samreportroutes/samrouteospfs'
      if @samrouteospfs.count > 20
        @samrouteospfs.first.delete
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
