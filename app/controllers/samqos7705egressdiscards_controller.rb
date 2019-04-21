class Samqos7705egressdiscardsController < ApplicationController

  def index
    @samqos7705egressdiscards = Samqos7705egressdiscard.all
    unless Samqos7705egressdiscard.last == nil
      @table_qos7705egressdiscard = Samqos7705egressdiscard.last[:samqos7705egressdiscards_array].paginate(:page => params[:page], :per_page => 500)
    end
    rescue => e
     flash[:error] = "Error de conexión con el SAM"
     redirect_to samqosreports_path
  end

  def show
    @samqos7705egressdiscard = Samqos7705egressdiscard.find(params[:samqos7705egressdiscard][:id])
    @table_qos7705egressdiscard_show = @samqos7705egressdiscard[:samqos7705egressdiscards_array].paginate(:page => params[:page], :per_page => 500)
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to samqosreports_samqos7705egressdiscards_path
  end

  def create
    @samqos7705egressdiscards = Samqos7705egressdiscard.all
    @samqos7705egressdiscard = Samqos7705egressdiscard.create(:samqos7705egressdiscards_array => Samqos7705egressdiscard.samqos7705egressdiscard_table)
    if @samqos7705egressdiscard.save
      @samqos7705egressdiscard.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/samqosreports/samqos7705egressdiscards'
      if @samqos7705egressdiscards.count > 20
        @samqos7705egressdiscards.first.delete
      end
    else
      flash[:error] = "Error al actualizar el reporte."
      render :new
    end    
    #rescue => e
    # flash[:error] = "Error de conexión con SAM"
    # redirect_to samqosreports_path
  end

end