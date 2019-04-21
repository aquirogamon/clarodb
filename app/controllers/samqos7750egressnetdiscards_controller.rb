class Samqos7750egressnetdiscardsController < ApplicationController

  def index
    @samqos7750egressnetdiscards = Samqos7750egressnetdiscard.all
    unless Samqos7750egressnetdiscard.last == nil
      @table_qos7750egressnetdiscard = Samqos7750egressnetdiscard.last[:samqos7750egressnetdiscards_array].paginate(:page => params[:page], :per_page => 500)
    end
    rescue => e
     flash[:error] = "Error de conexión con el SAM"
     redirect_to samqosdiscards_path
  end

  def show
    @samqos7750egressnetdiscard = Samqos7750egressnetdiscard.find(params[:samqos7750egressnetdiscard][:id])
    @table_qos7750egressnetdiscard_show = @samqos7750egressnetdiscard[:samqos7750egressnetdiscards_array].paginate(:page => params[:page], :per_page => 500)
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to samqosdiscards_samqos7750egressnetdiscards_path
  end

  def create
    @samqos7750egressnetdiscards = Samqos7750egressnetdiscard.all
    @samqos7750egressnetdiscard = Samqos7750egressnetdiscard.create(:samqos7750egressnetdiscards_array => Samqos7750egressnetdiscard.samqos7750egressnetdiscard_table)
    if @samqos7750egressnetdiscard.save
      @samqos7750egressnetdiscard.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/samqosdiscards/samqos7750egressnetdiscards'
      if @samqos7750egressnetdiscards.count > 20
        @samqos7750egressnetdiscards.first.delete
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