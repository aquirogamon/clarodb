class Samqos7750egressnetdiscard < ActiveRecord::Base

  serialize :samqos7750egressnetdiscards_array

  require 'rest-client'
  require 'json'
  require 'open-uri'
  require 'csv'

  def self.qos7750egressnetdiscard_summary
   xml = File.read("public/Discard_qos7750egressnet.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)
   return data_parsed
  end

  def self.samqos7750egressnetdiscard_table
   table = Array.new []
   data = qos7750egressnetdiscard_summary['Envelope']['Body']['findResponse']['result']['service.CombinedNetworkEgressOctetsLogRecord']

   data.map do |qosdiscard_device|
    @device = qosdiscard_device["monitoredObjectSiteName"]
    @port = qosdiscard_device["displayedName"]
    @queueId = qosdiscard_device["queueId"]
    @discardinprof = qosdiscard_device["inProfileOctetsDropped"].to_f
    @discardoutprof = qosdiscard_device["outOfProfileOctetsDropped"].to_f
    @time_unix = (qosdiscard_device["timeRecorded"]).to_i/1000
    @timeCaptured = Time.at(@time_unix).strftime("%B %e, %Y at %I:%M %p")
    @discard = @discardinprof + @discardoutprof
    unless @discard == 0
     hash = Hash[node: @device, port: @port, queueId: @queueId, discard: @discard, timeCaptured: @timeCaptured]
     table << hash   
    end
   end
  return table.sort! { |a,b| b[:discard] <=> a[:discard] }
  end
  
end
