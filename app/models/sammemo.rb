class Sammemo < ActiveRecord::Base

  serialize :sammemos_array

  require 'rest-client'
  require 'json'
  require 'open-uri'
  require 'csv'

  def self.memoryused_summary
   xml = File.read(Rails.root + "public/MEMORY_Used.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)
   return data_parsed
  end

  def self.memorylibre_summary
   xml = File.read(Rails.root + "public/MEMORY_Libre.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)
   return data_parsed
  end

  def self.element_summary
   xml = File.read("#{Rails.root}/public/Element.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)
   return data_parsed
  end

  def self.memory_table
   table = Array.new []
   data_used = memoryused_summary['Envelope']['Body']['findResponse']['result']['equipment.SystemMemoryStats']
   data_libre = memorylibre_summary['Envelope']['Body']['findResponse']['result']['equipment.AvailableMemoryStats']
   data_type = element_summary['Envelope']['Body']['findResponse']['result']['netw.NetworkElement']

   data_type.map do |device_element|
    @device = device_element["displayedName"]
    
    data_used.map do |memoryused_device|
     if memoryused_device["monitoredObjectSiteName"] == @device
      @memory_used = memoryused_device["systemMemoryUsage"].to_f
      break
     else
      @memory_used = '-'
     end
    end
    data_libre.map do |memorylibre_device|
     if memorylibre_device["monitoredObjectSiteName"] == @device
      @memory_libre = memorylibre_device["availableMemory"].to_f
      break
     else
      @memory_libre = '-'
     end
    end

    if (Float(@memory_libre) != nil rescue false ) && (Float(@memory_used) != nil rescue false)
        @status = ((@memory_used / (@memory_used + @memory_libre) ) * 100.00 ).round(2)
    else
      @status = 0.00
    end

    hash = Hash[node: @device, memory_used: @memory_used, memory_libre: @memory_libre, status: @status]
    table << hash
   end
  return table.sort! { |a,b| b[:status] <=> a[:status] }
  
  end
    
end