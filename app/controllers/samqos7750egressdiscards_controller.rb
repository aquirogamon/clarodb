class Samqos7750egressdiscardsController < ApplicationController

  def index
    @samqos7750egressdiscards = Samqos7750egressdiscard.all
    unless Samqos7750egressdiscard.last == nil
      @table_qos7750egressdiscard = Samqos7750egressdiscard.last[:samqos7750egressdiscards_array]
    end
    rescue => e
     flash[:error] = "Error de conexión con el SAM"
     redirect_to samqosdiscards_path
  end

  def show
    @samqos7750egressdiscard = Samqos7750egressdiscard.find(params[:samqos7750egressdiscard][:id])
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to samqosdiscards_samqos7750egressdiscards_path
  end

  def create
    @samqos7750egressdiscards = Samqos7750egressdiscard.all
    @samqos7750egressdiscard = Samqos7750egressdiscard.create(:samqos7750egressdiscards_array => Samqos7750egressdiscard.samqos7750egressdiscard_table)
    if @samqos7750egressdiscard.save
      @samqos7750egressdiscard.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/samqosdiscards/samqos7750egressdiscards'
      if @samqos7750egressdiscards.count > 10
        @samqos7750egressdiscards.first.delete
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