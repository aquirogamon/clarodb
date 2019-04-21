class Samrouteldp < ActiveRecord::Base

  serialize :samrouteldps_array

  require 'rest-client'
  require 'json'
  require 'open-uri'
  require 'csv'

  def self.routeldp_summary
   xml = File.read("#{Rails.root}/public/RouteLDP.xml")
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

  def self.samrouteldp_table
   table = Array.new []
   table_ldp_total = Array.new []
   data = routeldp_summary['Envelope']['Body']['findResponse']['result']['rtr.RouteStats']


   data.map do |route_device|
    @device = route_device["monitoredObjectSiteName"]
    @route_ldp = route_device["ldpActiveTunnels"].to_f
    hash = Hash[node: @device, route_ldp: @route_ldp]
    table << hash
   end

   table_ldp = table.group_by {|h| h[:node]}
   keys_ldp = table_ldp.keys
   ldp_all = keys_ldp.map {|k| Hash[k, table_ldp[k].reduce(0) {|t,h| t + h[:route_ldp]}]}

   ldp_all.each do |equipo_ldp|
    hash1 = {}
    hash1[:equipo] = equipo_ldp.keys[0]
    hash1[:route_ldp_total] = equipo_ldp.values[0]
    table_ldp_total << hash1
   end
   return table_ldp_total.sort! { |a,b| b[:route_ldp_total] <=> a[:route_ldp_total] }
  end

  def self.samrouteldpfinal_table
   table_final = Array.new []
   data_type = element_summary['Envelope']['Body']['findResponse']['result']['netw.NetworkElement']

   samrouteldp_table.map do |device_total|
    @device_final = device_total[:equipo]
    @ldp_final = (device_total[:route_ldp_total]).to_f
    
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
      @scalability_ldp = (scalability[5]).to_f
      @type_device = scalability[6]
      break
     else
      @scalability_ldp = '-'
     end
    end

   if (Float(@ldp_final) != nil rescue false ) && (Float(@scalability_ldp) != nil rescue false)
    @status = ((@ldp_final / @scalability_ldp) * 100.00 ).round(2)
   else
    @status = 0.00
   end
   hash_final = Hash[device_final: @device_final, ldp_final: @ldp_final, scalability_ldp: @scalability_ldp, status: @status, type_device: @type_device, version: @version]
   table_final << hash_final
   end
   return table_final.sort! { |a,b| b[:status] <=> a[:status] }
  end

end