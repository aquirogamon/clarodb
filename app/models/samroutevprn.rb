class Samroutevprn < ActiveRecord::Base

  serialize :samroutevprns_array

  require 'rest-client'
  require 'json'
  require 'open-uri'
  require 'csv'

  def self.routevprn_summary
   xml = File.read("#{Rails.root}/public/RouteVPRN.xml")
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

  def self.samroutevprn_table
   table = Array.new []
   table_vprn_total = Array.new []
   table_final = Array.new []
   data = routevprn_summary['Envelope']['Body']['findResponse']['result']['rtr.RouteStats']


   data.map do |route_device|
    @device = route_device["monitoredObjectSiteName"]
    @route_vprn = route_device["bgpVpnActiveRoutes"].to_f    
    hash = Hash[node: @device, route_vprn: @route_vprn]
    table << hash
   end

   table_vprn = table.group_by {|h| h[:node]}
   keys_vprn = table_vprn.keys
   vprn_all = keys_vprn.map {|k| Hash[k, table_vprn[k].reduce(0) {|t,h| t + h[:route_vprn]}]}

   vprn_all.each do |equipo_vprn|
    hash1 = {}
    hash1[:equipo] = equipo_vprn.keys[0]
    hash1[:route_vprn_total] = equipo_vprn.values[0]
    table_vprn_total << hash1
   end
   return table_vprn_total.sort! { |a,b| b[:route_vprn_total] <=> a[:route_vprn_total] }
  end

  def self.samroutevprnfinal_table
   table_final = Array.new []
   data_type = element_summary['Envelope']['Body']['findResponse']['result']['netw.NetworkElement']

   samroutevprn_table.map do |device_total|
    @device_final = device_total[:equipo]
    @vprn_final = (device_total[:route_vprn_total]).to_f
    
    data_type.map do |device_type|
     if device_type["displayedName"] == @device_final
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
      @scalability_vprn = (scalability[4]).to_f
      @type_device = scalability[6]
      break
     else
      @scalability_vprn = '-'
     end
    end

   if (Float(@vprn_final) != nil rescue false ) && (Float(@scalability_vprn) != nil rescue false)
    @status = ((@vprn_final / @scalability_vprn) * 100.00 ).round(2)
   else
    @status = 0.00
   end
   hash_final = Hash[device_final: @device_final, vprn_final: @vprn_final, scalability_vprn: @scalability_vprn, status: @status, type_device: @type_device, version: @version]
   table_final << hash_final
   end
   return table_final.sort! { |a,b| b[:status] <=> a[:status] }
  end

end