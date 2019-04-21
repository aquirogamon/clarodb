class SamroutevprnsController < ApplicationController

  def index
    @samroutevprns = Samroutevprn.all
    unless Samroutevprn.last == nil
      @table_routevprn = Samroutevprn.last[:samroutevprns_array].paginate(:page => params[:page], :per_page => 500)
    end
    rescue => e
     flash[:error] = "Error de conexión con el SAM"
     redirect_to samqosdiscards_path
  end

  def show
    @samroutevprn = Samroutevprn.find(params[:samroutevprn][:id])
    @table_routevprn_show = @samroutevprn[:samroutevprns_array].paginate(:page => params[:page], :per_page => 500)
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to samqosdiscards_samroutevprns_path
  end

  def create
    @samroutevprns = Samroutevprn.all
    @samroutevprn = Samroutevprn.create(:samroutevprns_array => Samroutevprn.samroutevprnfinal_table)
    if @samroutevprn.save
      @samroutevprn.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/samreportroutes/samroutevprns'
      if @samroutevprns.count > 20
        @samroutevprns.first.delete
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