class Samqos7705ingressdiscardsController < ApplicationController

  def index
    @samqos7705ingressdiscards = Samqos7705ingressdiscard.all
    unless Samqos7705ingressdiscard.last == nil
      @table_qos7705ingressdiscard = Samqos7705ingressdiscard.last[:samqos7705ingressdiscards_array].paginate(:page => params[:page], :per_page => 500)
    end
    rescue => e
     flash[:error] = "Error de conexión con el SAM"
     redirect_to samqosreports_path
  end

  def show
    @samqos7705ingressdiscard = Samqos7705ingressdiscard.find(params[:samqos7705ingressdiscard][:id])
    @table_qos7705ingressdiscard_show = @samqos7705ingressdiscard[:samqos7705ingressdiscards_array].paginate(:page => params[:page], :per_page => 500)
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to samqosreports_samqos7705ingressdiscards_path
  end

  def create
    @samqos7705ingressdiscards = Samqos7705ingressdiscard.all
    @samqos7705ingressdiscard = Samqos7705ingressdiscard.create(:samqos7705ingressdiscards_array => Samqos7705ingressdiscard.samqos7705ingressdiscard_table)
    if @samqos7705ingressdiscard.save
      @samqos7705ingressdiscard.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/samqosreports/samqos7705ingressdiscards'
      if @samqos7705ingressdiscards.count > 20
        @samqos7705ingressdiscards.first.delete
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