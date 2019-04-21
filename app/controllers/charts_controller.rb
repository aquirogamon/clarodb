class ChartsController < ApplicationController

  def traffic_internetinterfaces
      render json: InternetInterface.where(deviceindex: @internet_interface.deviceindex).pluck(:created_at, :bps_max).map { |e| [ e[0].strftime("%U-%Y"), e[1] ] }
  end

end