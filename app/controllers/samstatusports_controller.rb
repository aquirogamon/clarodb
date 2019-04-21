class SamstatusportsController < ApplicationController

  def index
    @samstatusports = Samstatusport.all
    unless Samstatusport.last == nil
      @table_statusport = Samstatusport.last[:samstatusports_array]
    end
    respond_to do |format|
       format.html
       format.xls do
         render :xls => "Reporte de puertos Nokia - " + Samstatusport.last.created_at.strftime("%d/%m/%Y %H:%M:%S"),
         :encoding => "UTF-8",
         :disposition => "attachment"
       end
       #format.pdf do
       #  render :pdf => "Reporte Internet Corporativo", :encoding => "UTF-8", :type=>"application/pdf"
       #end
    end
  end

  def show
    @samstatusport = Samstatusport.find(params[:samstatusport][:id])
    @table_statusport_show = @samstatusport[:samstatusports_array].paginate(:page => params[:page], :per_page => 500)
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to samqosdiscards_samstatusports_path
  end

  def create
    @samstatusports = Samstatusport.all
    @samstatusport = Samstatusport.create(:samstatusports_array => Samstatusport.samstatusport_table)
    if @samstatusport.save
      @samstatusport.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/samqosdiscards/samstatusports'
      if @samstatusports.count > 20
        @samstatusports.first.delete
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