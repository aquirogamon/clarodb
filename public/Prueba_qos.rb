
  require 'rest-client'
  require 'json'
  require 'open-uri'
  require 'csv'

  def self.qos7705egressdiscard_summary
   xml = File.read("#{Rails.root}/public/Prueba.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)
   return data_parsed
  end

  def self.samqos7705egressdiscardtotal_table
   tabletotal = Array.new []
   data_stats = qos7705egressdiscard_summary['Envelope']['Body']['findResponse']['result']['service.SapEgrQosQueueStatsLogRecord']

   data_stats.map do |qosdiscard_device|
    @devicetotal = qosdiscard_device["monitoredObjectSiteName"]
    @servicetotal = qosdiscard_device["svcId"]
    @porttotal = qosdiscard_device["displayedName"]
    @saptotal = qosdiscard_device["sapId"]
    @queueIdtotal = qosdiscard_device["queueId"]
    @discardinproftotal = qosdiscard_device["inProfileOctetsDropped"].to_i
    @discardoutproftotal = qosdiscard_device["outOfProfileOctetsDropped"].to_i
    time_unixtotal = (qosdiscard_device["timeCaptured"]).to_i/1000
    @timeCapturedtotal = Time.at(time_unixtotal).strftime("%B %e, %Y at %I:%M %p")
    @discardtotal = @discardinproftotal + @discardoutproftotal
    @device_int_stats_total = (@devicetotal+@porttotal+@queueIdtotal).to_s
     hash = Hash[devicetotal: @devicetotal, servicetotal: @servicetotal, porttotal: @porttotal, queueIdtotal: @queueIdtotal, discardtotal: @discardtotal, device_int_stats_total: @device_int_stats_total, timeCapturedtotal: @timeCapturedtotal, time_unixtotal: time_unixtotal]
     tabletotal << hash
   end

   tabletotalsort = tabletotal.sort! { |a,b| b[:timeCapturedtotal] <=> a[:timeCapturedtotal] }

   groupedtotal  = tabletotalsort.group_by {|h| h[:device_int_stats_total]}
   
   keystotal = groupedtotal.keys

      arr_sub = keystotal.map { |k|
      [k, groupedtotal[k].each_cons(2).map do |g,h|
          { devicetotal: g[:devicetotal], servicetotal: g[:servicetotal], porttotal: g[:porttotal], queueIdtotal: g[:queueIdtotal], device_int_stats_total: g[:device_int_stats_total], timeCapturedtotal: g[:timeCapturedtotal] , discard_sub: g[:discardtotal]-h[:discardtotal]}
      end
      ]
      }

   table_sub1 = Array.new []
   table_sub2 = Array.new []
   arr_sub.each do |traf_sub|
    table_sub1 << traf_sub[1]
   end
   table_sub1.each do |traf_sub|
    table_sub2 << traf_sub[1]
   end
  end


  def self.statsinterfacemax_table

   tablemax = Array.new []
   samqos7705egressdiscardtotal_table.map do |stats_device|
    @devicemax = stats_device[:devicetotal]
    @servicemax = stats_device[:servicetotal]
    @portmax = stats_device[:porttotal]
    @queueIdmax = stats_device[:queueIdtotal]
    @discard_max = (((stats_device[:discard_sub].to_f)/300)).round(2)
    @timeCapturedmax = stats_device[:timeCapturedmax]
    @device_int_stats_max = stats_device[:timeCapturedtotal]
     hash = Hash[devicemax: @devicemax, service: @servicemax, port: @portmax, queueId: @queueIdmax, discard_max: @discardmax, device_int_stats_max: @device_int_stats_max, timeCapturedmax: @timeCapturedmax]
     tablemax << hash
   end
   groupedmax  = tablemax.group_by {|h| h[:device_int_stats_max]}
   keysmax = groupedmax.keys
   arrmax = keysmax.map {|k| [k, groupedmax[k].max_by {|h| h[:discard_max]}]}



   end

