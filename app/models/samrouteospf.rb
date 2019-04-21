class Samrouteospf < ActiveRecord::Base

  serialize :samrouteospfs_array

  require 'rest-client'
  require 'json'
  require 'open-uri'
  require 'csv'

  def self.routeospf_summary
   xml = File.read("#{Rails.root}/public/RouteOSPF.xml")
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

  def self.scalability
    scalabilitynokia_array = CSV.read(Rails.root + "public/scalability_local_nokia.csv")
  end

  def self.samrouteospf_table
   table = Array.new []
   data_ospf = routeospf_summary['Envelope']['Body']['findResponse']['result']['rtr.RouteStats']
   data_type = element_summary['Envelope']['Body']['findResponse']['result']['netw.NetworkElement']

 
   data_ospf.map do |device_routes|
    @device = device_routes["monitoredObjectSiteName"]
    @ospf = (device_routes["ospfActiveRoutes"]).to_f
    
    data_type.map do |device_type|
     if device_type["displayedName"] == @device
      @version = device_type["version"].to_s
      @chassisType = device_type["chassisType"].to_s
      @chassisTypeversion = (@chassisType + @version).to_s
      break
     else
      @chassisTypeversion = '-'
     end
    end
    scalability.map do |scalability|
     if scalability[2] == @chassisTypeversion
      @scalability_ospf = (scalability[3]).to_f
      break
     else
      @scalability_ospf = '-'
     end
    end

   if (Float(@ospf) != nil rescue false ) && (Float(@scalability_ospf) != nil rescue false)
    @status = ((@ospf / @scalability_ospf) * 100.00 ).round(2)
   else
    @status = 0.00
   end
   hash = Hash[device: @device, ospf: @ospf, scalability_ospf: @scalability_ospf, status: @status, version: @version]
   table << hash
   end
   return table.sort! { |a,b| b[:status] <=> a[:status] }
  end

end
