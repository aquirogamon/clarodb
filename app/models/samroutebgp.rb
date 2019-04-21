class Samroutebgp < ActiveRecord::Base

  serialize :samroutebgps_array

  require 'rest-client'
  require 'json'
  require 'open-uri'
  require 'csv'

  def self.routebgp_summary
   xml = File.read("#{Rails.root}/public/RouteBGP.xml")
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

  def self.samroutebgp_table
   table = Array.new []
   table_bgp_total = Array.new []
   data = routebgp_summary['Envelope']['Body']['findResponse']['result']['rtr.RouteStats']


   data.map do |route_device|
    @device = route_device["monitoredObjectSiteName"]
    @route_bgp = route_device["bgpActiveRoutes"].to_f
    hash = Hash[node: @device, route_bgp: @route_bgp]
    table << hash
   end

   table_bgp = table.group_by {|h| h[:node]}
   keys_bgp = table_bgp.keys
   bgp_all = keys_bgp.map {|k| Hash[k, table_bgp[k].reduce(0) {|t,h| t + h[:route_bgp]}]}

   bgp_all.each do |equipo_bgp|
    hash1 = {}
    hash1[:equipo] = equipo_bgp.keys[0]
    hash1[:route_bgp_total] = equipo_bgp.values[0]
    table_bgp_total << hash1
   end
   return table_bgp_total.sort! { |a,b| b[:route_bgp_total] <=> a[:route_bgp_total] }
  end

  def self.samroutebgpfinal_table
   table_final = Array.new []
   data_type = element_summary['Envelope']['Body']['findResponse']['result']['netw.NetworkElement']

   samroutebgp_table.map do |device_total|
    @device_final = device_total[:equipo]
    @bgp_final = (device_total[:route_bgp_total]).to_f
    
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
      @scalability_bgp = (scalability[5]).to_f
      @type_device = scalability[6]
      break
     else
      @scalability_bgp = '-'
     end
    end

   if (Float(@bgp_final) != nil rescue false ) && (Float(@scalability_bgp) != nil rescue false)
    @status = ((@bgp_final / @scalability_bgp) * 100.00 ).round(2)
   else
    @status = 0.00
   end
   hash_final = Hash[device_final: @device_final, bgp_final: @bgp_final, scalability_bgp: @scalability_bgp, status: @status, type_device: @type_device, version: @version]
   table_final << hash_final
   end
   return table_final.sort! { |a,b| b[:status] <=> a[:status] }
  end

end