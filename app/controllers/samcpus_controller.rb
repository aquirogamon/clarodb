class SamcpusController < ApplicationController

  def index
    @samcpus = Samcpu.all
    unless Samcpu.last == nil
      @table_cpu = Samcpu.last[:samcpus_array].paginate(:page => params[:page], :per_page => 500)
    end
    #rescue => e
    # flash[:error] = "Error de conexión con el SAM"
    # redirect_to samreports_path
  end

  def show
    @samcpu = Samcpu.find(params[:samcpu][:id])
    @table_cpu_show = @samcpu[:samcpus_array].paginate(:page => params[:page], :per_page => 500)
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to samreports_samcpus_path
  end

  def create
    @samcpus = Samcpu.all
    @samcpu = Samcpu.create(:samcpus_array => Samcpu.cpu_table)
    if @samcpu.save
      @samcpu.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/samreports/samcpus'
      if @samcpus.count > 10
        @samcpus.first.delete
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