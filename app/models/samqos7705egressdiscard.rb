class Samqos7705egressdiscard < ActiveRecord::Base

  serialize :samqos7705egressdiscards_array

  require 'rest-client'
  require 'json'
  require 'open-uri'
  require 'csv'

  def self.qos7705egressdiscard_summary
   xml = File.read("#{Rails.root}/public/Discard_qos7705egress.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)
   return data_parsed
  end

  def self.samqos7705egressdiscardtotal_table
   tabletotal = Array.new []
   data_stats = qos7705egressdiscard_summary['Envelope']['Body']['findResponse']['result']['service.SapEgrQosQueueStatsLogRecord']

   data_stats.map do |qosdiscard_device|
    devicetotal = qosdiscard_device["monitoredObjectSiteName"]
    porttotal = qosdiscard_device["displayedName"]
    queueIdtotal = qosdiscard_device["queueId"]
    discardinproftotal = qosdiscard_device["droppedInProfOctets"].to_i
    discardoutproftotal = qosdiscard_device["droppedOutProfOctets"].to_i
    time_unixtotal = (qosdiscard_device["timeCaptured"]).to_i/1000
     hash = Hash[devicetotal: devicetotal, porttotal: porttotal, queueIdtotal: queueIdtotal, discardtotal: (discardinproftotal + discardoutproftotal), device_int_stats_total: (devicetotal+porttotal+queueIdtotal).to_s, timeCapturedtotal: (Time.at(time_unixtotal).strftime("%B %e, %Y at %I:%M %p")), time_unixtotal: time_unixtotal]
     tabletotal << hash
   end

   return tabletotal.sort! { |a,b| b[:time_unixtotal] <=> a[:time_unixtotal] }
  end

  def self.samqos7705egressdiscardsub_table
     table_sub = samqos7705egressdiscardtotal_table.group_by{ |x| x[:device_int_stats_total] }.values.map{ |gp| gp.each_cons(2).map do |g,h|
            { devicetotal: g[:devicetotal], porttotal: g[:porttotal], queueIdtotal: g[:queueIdtotal], device_int_stats_total: g[:device_int_stats_total], discard_sub: g[:discardtotal]-h[:discardtotal], time_unix_sub: g[:time_unixtotal]-h[:time_unixtotal]}
        end
        }
     return table_sub.map { |ts| ts[1] }.flatten.compact   
  end


  def self.samqos7705egressdiscard_table

   table = Array.new []
   samqos7705egressdiscardsub_table.map do |stats_device|
    device = stats_device[:devicetotal]
    port = stats_device[:porttotal]
    queueId = stats_device[:queueIdtotal]
    periodicTime = stats_device[:time_unix_sub]
    discard = (((stats_device[:discard_sub].to_f)*8/(periodicTime*1000000))).round(2)
    device_int_stats = stats_device[:device_int_stats_total]
    if discard > 0
     hash = Hash[node: device, port: port, queueId: queueId, discard: discard, device_int_stats: device_int_stats]
     table << hash
    end
   end
   tablemax = table.group_by{ |x| x[:device_int_stats] }.values.map{ |gp| gp.max_by{ |st| st[:discard] }}

  return tablemax.compact.sort! { |a,b| b[:discard] <=> a[:discard] }
  end

end
