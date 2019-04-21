class SamospfalarmasController < ApplicationController

  def index
    @samospfalarmas = Samospfalarma.all
    unless Samospfalarma.last == nil
      @table_ospfalarma = Samospfalarma.last[:samospfalarmas_array]
    end
    rescue => e
     flash[:error] = "Error de conexión con el SAM"
     redirect_to samreportalarmas_path
  end

  def show
    @samospfalarma = Samospfalarma.find(params[:samospfalarma][:id])
    @table_ospfalarma_show = @samospfalarma[:samospfalarmas_array].paginate(:page => params[:page], :per_page => 500)
    rescue => e
     flash[:error] = "Escoja un reporte válido."
     redirect_to samreportalarmas_samospfalarmas_path
  end

  def create
    @samospfalarmas = Samospfalarma.all
    @samospfalarma = Samospfalarma.create(:samospfalarmas_array => Samospfalarma.samospfalarma_table)
    if @samospfalarma.save
      @samospfalarma.created_at.in_time_zone('Eastern Time (US & Canada)')
      flash[:notice] = "Reporte actualizado y almacenado."
      redirect_to '/samreportalarmas/samospfalarmas'
      if @samospfalarmas.count > 20
        @samospfalarmas.first.delete
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