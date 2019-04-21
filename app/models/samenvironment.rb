class Samenvironment < ActiveRecord::Base

  serialize :samenvironments_array

  require 'rest-client'
  require 'json'
  require 'open-uri'
  require 'csv'

  def self.environment_summary
   xml = File.read("#{Rails.root}/public/Temperatura.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)
   return data_parsed
  end

  def self.samenvironment_table
   table = Array.new []
   data = environment_summary['Envelope']['Body']['findResponse']['result']['equipment.HardwareTemperature']

   data.map do |environment_device|
    @device = environment_device["monitoredObjectSiteName"]
    @temperature = environment_device["temperature"].to_f
    
    hash = Hash[node: @device, status: @temperature]
    table << hash
   end
  return table.sort! { |a,b| b[:status] <=> a[:status] }
  end

end
