class Samqos7750egressdiscard < ActiveRecord::Base

  serialize :samqos7750egressdiscards_array

  require 'rest-client'
  require 'json'
  require 'open-uri'
  require 'csv'

  def self.qos7750egressdiscard_summary
   xml = File.read("public/Discard_qos7750egress.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)
   return data_parsed
  end

  def self.samqos7750egressdiscard_table
   table = Array.new []
   data = qos7750egressdiscard_summary['Envelope']['Body']['findResponse']['result']['service.CompleteServiceEgressPacketOctetsLogRecord']

   data.map do |qosdiscard_device|
    @device = qosdiscard_device["monitoredObjectSiteName"]
    @svcId = qosdiscard_device["svcId"]
    @sap = qosdiscard_device["sapId"]
    @description = qosdiscard_device["displayedName"]
    @queueId = qosdiscard_device["queueId"]
    @discardinprof = qosdiscard_device["inProfileOctetsDropped"].to_f
    @discardoutprof = qosdiscard_device["outOfProfileOctetsDropped"].to_f
    @time_unix = (qosdiscard_device["timeCaptured"]).to_i/1000
    @timeCaptured = Time.at(@time_unix).strftime("%B %e, %Y at %I:%M %p")
    @discard = @discardinprof + @discardoutprof
    unless @discard == 0
     hash = Hash[node: @device, svcId: @svcId, sap: @sap, description: @description, queueId: @queueId, discard: @discard, timeCaptured: @timeCaptured]
     table << hash   
    end
   end
  return table.sort! { |a,b| b[:discard] <=> a[:discard] }
  end

end