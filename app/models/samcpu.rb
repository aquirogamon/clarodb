class Samcpu < ActiveRecord::Base

  serialize :samcpus_array

  require 'rest-client'
  require 'json'
  require 'open-uri'
  require 'csv'

  def self.cpu_summary
   xml = File.read("#{Rails.root}/public/CPU.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)
   return data_parsed
  end

  def self.cpu_table
   table = Array.new []
   data = cpu_summary['Envelope']['Body']['findResponse']['result']['equipment.SystemCpuMonStats']

   data.map do |cpu_device|
    @device = cpu_device["monitoredObjectSiteName"]
    @cpu = cpu_device["tmnxSysCpuMonBusyCoreUtil"].to_f
    
    hash = Hash[node: @device, status: @cpu]
    table << hash
   end
  return table.sort! { |a,b| b[:status] <=> a[:status] }
  end
  
end