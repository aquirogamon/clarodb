class Samstatusport < ActiveRecord::Base

  serialize :samstatusports_array

  require 'rest-client'
  require 'json'
  require 'open-uri'
  require 'csv'

  def self.statusport_summary
   xml = File.read("#{Rails.root}/public/Statusport.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)
   return data_parsed
  end

  def self.speed_nokia
    speednokia_array = CSV.read(Rails.root + "public/speed_nokia.csv")
  end

  def self.equipos_alu
    speednokia_array = CSV.read(Rails.root + "public/Equipos_ALU.csv")
  end  

  def self.samstatusport_table
   table = Array.new []
   data = statusport_summary['Envelope']['Body']['findResponse']['result']['equipment.PhysicalPort']

   data.map do |device_routes|
    @device = device_routes["siteName"]
    @port = device_routes["displayedName"]
    actualSpeed_SAM = device_routes["actualSpeed"].to_i
    @actualSpeed = actualSpeed_SAM/1000
    @description = device_routes["description"]
    @portClass = device_routes["portClass"]
    equipos_alu.map do |equipos_alu|
     if equipos_alu[0] == @device
       @tipo_equipo = equipos_alu[1]
     end
    end
    speed_nokia.map do |speed_nokia|
     if speed_nokia[0] == @portClass
       @speed_real = (speed_nokia[1]).to_i
       @speed = speed_nokia[2]
       break
     else
       @speed_real = '-'
     end
    end
    if @actualSpeed == 100
      @status = 1.0
    else
      @status = 0.0
    end
    unless @status == 0
     hash = Hash[device: @device, port: @port, tipo_equipo: @tipo_equipo, actualSpeed: @actualSpeed, speed: @speed, description: @description, status: @status]
     table << hash  
    end
   end
   return table.sort! { |a,b| b[:speed] <=> a[:speed] }
  end

end
