class Samutilizationaccesointerface < ActiveRecord::Base

  serialize :samutilizationaccesointerfaces_array

  require 'rest-client'
  require 'json'
  require 'open-uri'
  require 'csv'
  require 'date'

    def self.interfacestats_summary
     xml = File.read("#{Rails.root}/public/InterfaceStats_Acceso.xml")
     data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
     data_parsed = Hash.from_xml(data)
     return data_parsed
    end

    def self.rateinterface_summary
     xml = File.read("#{Rails.root}/public/EthernetPort.xml")
     data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
     data_parsed = Hash.from_xml(data)
     return data_parsed
    end

    def self.physicalport_summary
     xml = File.read("#{Rails.root}/public/PhysicalPort.xml")
     data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
     data_parsed = Hash.from_xml(data)
     return data_parsed
    end

    def self.speed_nokia
     speednokia_array = CSV.read(Rails.root + "public/speed_nokia.csv")
    end

    def self.statsinterfacetotal_table
     tabletotal = Array.new []
     data_stats = interfacestats_summary['Envelope']['Body']['findResponse']['result']['equipment.InterfaceAdditionalStatsLogRecord']

     data_stats.map do |qosdiscard_device|
      devicetotal = qosdiscard_device["monitoredObjectSiteName"]
      porttotal = qosdiscard_device["displayedName"]
      octetsrxtotal = qosdiscard_device["receivedTotalOctets"].to_i
      octetstxtotal = qosdiscard_device["transmittedTotalOctets"].to_i
      time_unixtotal = (qosdiscard_device["timeCaptured"]).to_i/1000
       hash = Hash[devicetotal: devicetotal, porttotal: porttotal, octetsrxtotal: octetsrxtotal, octetstxtotal: octetstxtotal, 
        device_int_stats_total: (devicetotal+porttotal).to_s, timeCapturedtotal: (Time.at(time_unixtotal).strftime("%B %e, %Y at %I:%M %p")), 
        time_unixtotal: time_unixtotal]
       tabletotal << hash
     end

     return tabletotal.sort! { |a,b| b[:time_unixtotal] <=> a[:time_unixtotal] }
    end

    def self.statsinterfacesub_table
     table_sub = statsinterfacetotal_table.group_by{ |x| x[:device_int_stats_total] }.values.map{ |gp| gp.each_cons(2).map do |g,h|
            { devicetotal: g[:devicetotal], porttotal: g[:porttotal], device_int_stats_total: g[:device_int_stats_total], 
              octetsrxsub: g[:octetsrxtotal]-h[:octetsrxtotal], octetstxsub: g[:octetstxtotal]-h[:octetstxtotal], 
              time_unixsub: g[:time_unixtotal]-h[:time_unixtotal], time_unixtotal: g[:time_unixtotal], 
              timeCapturedtotal: g[:timeCapturedtotal]}
        end
        }
     return table_sub.map { |ts| ts[1] }.flatten.compact     
    end


    def self.statsinterfacemax_table

     tablemax = Array.new []
     statsinterfacesub_table.map do |stats_device|
      nodesub = stats_device[:devicetotal]
      portsub = stats_device[:porttotal]
      time_unix = stats_device[:time_unixsub]
      timeCapturedsub = stats_device[:timeCapturedtotal]
      bwrxmax = (((stats_device[:octetsrxsub].to_f)*8/(time_unix*1000000))).round(2)
      bwtxmax = (((stats_device[:octetstxsub].to_f)*8/(time_unix*1000000))).round(2)
      device_int_stats = stats_device[:device_int_stats_total]
        if bwrxmax > bwtxmax
          bwmax = bwrxmax
        else
          bwmax = bwtxmax
        end
       hash = Hash[nodemax: nodesub, portmax: portsub, bwmax: bwmax, bwrxmax: bwrxmax, bwtxmax: bwtxmax, 
        device_int_stats: device_int_stats, timeCapturedmax: timeCapturedsub]
       tablemax << hash
     end

     tablemax.group_by{ |x| x[:device_int_stats] }.values.map{ |gp| gp.max_by{ |st| st[:bwmax] }}
    end

    def self.statsinterface_table
     table_stats = Array.new []
     data_rate = rateinterface_summary['Envelope']['Body']['findResponse']['result']['ethernetequipment.EthernetPortSpecifics']
     data_description = physicalport_summary['Envelope']['Body']['findResponse']['result']['equipment.PhysicalPort']
     
     statsinterfacemax_table.map do |stats_device|
      @Mbps_bwrx = stats_device[:bwrxmax].to_f
      @Mbps_bwtx = stats_device[:bwtxmax].to_f
      @Mbps_bw = stats_device[:bwmax].to_f
      @timeCaptured = stats_device[:timeCapturedmax]
      @port = stats_device[:portmax]
      @device = stats_device[:nodemax]
      @device_int_stats = (@device+@port).to_s

      data_description.map do |interface_description|
       @port_des = (interface_description["displayedName"]).to_s
       @device_des = (interface_description["siteName"]).to_s
       @device_int_description = (@device_des+@port_des).to_s

       if @device_int_description == @device_int_stats
        @description = interface_description["description"]
        @actualSpeed2 = interface_description["actualSpeed"]

         data_rate.map do |interface_rate|
          port_rate = (interface_rate["displayedName"]).to_s
          device_rate = (interface_rate["siteName"]).to_s
          @device_int_rate = (device_rate+port_rate).to_s
          @portClass = interface_rate["portClass"]
          @egressRate = interface_rate["egressRate"]
          
          if @device_int_rate == @device_int_stats
            speed_nokia.map do |speed_nokia|
              if speed_nokia[0] == @portClass
                @speed = speed_nokia[2]
              else
                @speed = '-'
              end
            end
            if @egressRate == "-1"
              @actualSpeed = (@actualSpeed2).to_i/1000
            else
              @actualSpeed = (@egressRate).to_i/1000
            end
          end
         end
       else
        @speed = '-'
        @actualSpeed = '-'
       end
      end

      unless @bw == 0
        if (Float(@Mbps_bw) != nil rescue false ) && (Float(@actualSpeed) != nil rescue false)

            @status = ((@Mbps_bw / @actualSpeed) * 100.00 ).round(2)
        else
          @status = 0.00
        end
        hash = Hash[node: @device, Mbps_bwrx: @Mbps_bwrx, Mbps_bwtx: @Mbps_bwtx, status: @status, velodidad: @actualSpeed, 
          port: @port, description: @description, timeCaptured: @timeCaptured, speed: @speed]
        table_stats << hash
      end
     end
    return table_stats.sort! { |a,b| b[:status] <=> a[:status] }
    end

end
