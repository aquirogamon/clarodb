class Saminterfacediscard < ActiveRecord::Base

  serialize :saminterfacediscards_array

  require 'rest-client'
  require 'json'
  require 'open-uri'
  require 'csv'

  def self.interfacediscard_summary
   xml = File.read("#{Rails.root}/public/Discard_interface.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)
   return data_parsed
  end

  def self.saminterfacediscard_table
   table = Array.new []
   data = interfacediscard_summary['Envelope']['Body']['findResponse']['result']['equipment.InterfaceStatsLogRecord']

   data.map do |qosdiscard_device|
    @device = qosdiscard_device["monitoredObjectSiteName"]
    @port = qosdiscard_device["displayedName"]
    @discardin = qosdiscard_device["receivedPacketsDiscarded"].to_f
    @discardout = qosdiscard_device["outboundPacketsDiscarded"].to_f
    @discardin_incremento = qosdiscard_device["receivedPacketsDiscardedPeriodic"].to_f
    @discardout_incremento = qosdiscard_device["outboundPacketsDiscardedPeriodic"].to_f
    @discard = @discardin + @discardout
    @discard_incremento = @discardin_incremento + @discardout_incremento
    @time_unix = (qosdiscard_device["timeCaptured"]).to_i/1000
    @timeCaptured = Time.at(@time_unix).strftime("%B %e, %Y at %I:%M %p")
    unless @discard == 0 || @discard_incremento == 0
     hash = Hash[node: @device, port: @port, discardin: @discardin, discardout: @discardout, discard: @discard, discard_incremento: @discard_incremento, timeCaptured: @timeCaptured]
     table << hash   
    end

   end
  return table.sort! { |a,b| b[:discard] <=> a[:discard] }
  end

end
