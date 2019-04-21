class Samqos7705ingressdiscard < ActiveRecord::Base

  serialize :samqos7705ingressdiscards_array

  require 'rest-client'
  require 'json'
  require 'open-uri'
  require 'csv'


  def self.qos7705ingressdiscard_summary
   xml = File.read("#{Rails.root}/public/Discard_qos7705ingress.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)
   return data_parsed
  end


  def self.samqos7705ingressdiscardtotal_table
   tabletotal = Array.new []
   data_stats = qos7705ingressdiscard_summary['Envelope']['Body']['findResponse']['result']['service.SapIngQosQueueStatsLogRecord']

   data_stats.map do |qosdiscard_device|
    devicetotal = qosdiscard_device["monitoredObjectSiteName"]
    porttotal = qosdiscard_device["displayedName"]
    queueIdtotal = qosdiscard_device["queueId"]
    discardhiprioproftotal = qosdiscard_device["droppedHiPrioOctets"].to_i
    discardloprioproftotal = qosdiscard_device["droppedLoPrioOctets"].to_i
    time_unixtotal = (qosdiscard_device["timeCaptured"]).to_i/1000
     hash = Hash[devicetotal: devicetotal, porttotal: porttotal, queueIdtotal: queueIdtotal, discardtotal: (discardhiprioproftotal + discardloprioproftotal), device_int_stats_total: (devicetotal+porttotal+queueIdtotal).to_s, timeCapturedtotal: (Time.at(time_unixtotal).strftime("%B %e, %Y at %I:%M %p")), time_unixtotal: time_unixtotal]
     tabletotal << hash
   end

   return tabletotal.sort! { |a,b| b[:time_unixtotal] <=> a[:time_unixtotal] }
  end


  def self.samqos7705ingressdiscardsub_table
   groupedtotal  = samqos7705ingressdiscardtotal_table.group_by {|h| h[:device_int_stats_total]}
   
   keystotal = groupedtotal.keys

      arr_sub = keystotal.map { |k|
      [k, groupedtotal[k].each_cons(2).map do |g,h|
          { devicetotal: g[:devicetotal], porttotal: g[:porttotal], queueIdtotal: g[:queueIdtotal], device_int_stats_total: g[:device_int_stats_total], discard_sub: g[:discardtotal]-h[:discardtotal]}
      end
      ]
      }
   
   table_sub = Array.new []
   arr_sub.each do |traf_sub|
    table_sub << traf_sub[1]
   end
   table_sub.map(&:first).compact
  end


  def self.samqos7705ingressdiscard_table

   table = Array.new []
   samqos7705ingressdiscardsub_table.map do |stats_device|
    device = stats_device[:devicetotal]
    port = stats_device[:porttotal]
    queueId = stats_device[:queueIdtotal]
    discard = (((stats_device[:discard_sub].to_f)*8/300000)).round(2)
    device_int_stats = stats_device[:device_int_stats_total]
    if discard > 0
     hash = Hash[node: device, port: port, queueId: queueId, discard: discard, device_int_stats: device_int_stats]
     table << hash
    end
   end
   return table.compact.sort! { |a,b| b[:discard] <=> a[:discard] }

   groupedmax  = table.group_by {|h| h[:device_int_stats]}
   keysmax = groupedmax.keys
   arrmax = keysmax.map {|k| [k, groupedmax[k].max_by {|h| h[:discard]}]}

   table_max1 = Array.new []
   table_max2 = Array.new []
   arrmax.each do |traf_sub|
    table_max1 << traf_sub[1]
   end
   table_max1.each do |traf_sub|
    table_max2 << traf_sub[1]
   end
  end

end
