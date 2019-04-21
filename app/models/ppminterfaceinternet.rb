class Ppminterfaceinternet < ActiveRecord::Base

  serialize :ppminterfaceinternets_array


  require 'rest-client'
  require 'json'
  require 'csv'

  def self.transport_stats(ip_address)
    fqdn = '&FQDN=Node%3D' + ip_address
    #base_url = "https://aquiroga:Cl4r0peru51@172.19.212.8:4440/ppm/rest/reports/Transport+Statistics/Interface/Interface+Bit+Rates?outputType=jsonv2&durationSelect=lastDay&intervalTypeKey=HOUR&maxPageSize=200000" + fqdn
    base_url = "https://aquiroga:Cl4r0peru51@172.19.212.8:4440/ppm/rest/reports/Transport+Statistics/Interface/Interface+Bit+Rates?outputType=jsonv2&durationSelect=last3Days&intervalTypeKey=FIVE_MINUTE&maxPageSize=200000" + fqdn
    begin
      data = RestClient::Request.execute(:url => base_url , :method => :get, :verify_ssl => false)
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
    data_parsed = JSON.load(data)
    return data_parsed["report"]["data"]
  end

  def self.deviceppm
    deviceppm_array = CSV.read(Rails.root + "public/deviceppm.csv")[1..-1]
  end

  def self.devinternet
    interfaceinternet_array = CSV.read(Rails.root + "public/internet.csv")[1..-1]
  end

  def self.host
    csv_data = CSV.read(Rails.root + "public/internet.csv")

    keys = Array.new []
    headers = csv_data.shift.map {|i| i.to_s }
    string_data = csv_data.map {|row| row.map {|cell| cell.to_s } }
    array_of_hashes = string_data.map {|row| Hash[*headers.zip(row).flatten] }
    grouped  = array_of_hashes.group_by {|h| h["Host"]}
    keys = grouped.keys.zip
  end

  def self.statsinterfacetotal_table
   
   tabletotal = Array.new []
   host.map do |host_key|
    @hosttotal = host_key[0]
    data_stats = Hash.new { |hash, key| hash[key] = [] }
    data_stats = transport_stats(@hosttotal)
      data_stats.map do |stats_device|
          @gbpsrxtotal = ((stats_device[6].gsub(/,/, '').to_f)/1000000000).round(2)
          @gbpstxtotal = ((stats_device[5].gsub(/,/, '').to_f)/1000000000).round(2)
          @indextotal = stats_device[3]
          #hostindextotal = hosttotal+indextotal
          porttotal = stats_device[0]
          deviceppm.map do |deviceppm|
            @hostppmtotal = deviceppm[1]
            if @hostppmtotal == @hosttotal
              @devicetotal = deviceppm[0]
              @deviceindextotal = (@devicetotal + @indextotal).to_s
              @egressRatetotalppm = (stats_device[4].gsub(/,/, '').to_i)/1000000000
              if @gbpsrxtotal > @gbpstxtotal
                @bps_max = @gbpsrxtotal
                @statustotal = ((@bps_max / @egressRatetotalppm) * 100.00 ).round(2)
              else
                @bps_max = @gbpstxtotal
                @statustotal = ((@bps_max / @egressRatetotalppm) * 100.00 ).round(2)
              end
            devinternet.map do |devinternet|
             @hostindexdevice = (devinternet[8]).to_s
             if @deviceindextotal == @hostindexdevice
              @device = (devinternet[1]).to_s
              @neighbor = devinternet[6]
              hash = Hash[device_total: @device, 
                          port_total: porttotal, 
                          servicio_total: devinternet[5], 
                          gbpsrx_total: @gbpsrxtotal, 
                          gbpstx_total: @gbpstxtotal, 
                          bps_max_total: @bps_max, 
                          status_total: @statustotal, 
                          egressRate_total: @egressRatetotalppm, 
                          neighbor_total: @neighbor, 
                          deviceindex_total: @deviceindextotal]
              tabletotal << hash
             end
            end
            end
          end
      end
   end
  return tabletotal.flatten.group_by{ |x| x[:deviceindex_total] }.values.map{ |gp| gp.max_by{ |st| st[:status_total] }}.sort! { |a,b| b[:status_total] <=> a[:status_total] }
  end

  def self.statsinterfacecrecimiento_table
   tablecrecimiento = Array.new []
   statsinterfacetotal_table.map do |statstotal|
    @device = statstotal[:device_total]
    @port = statstotal[:port_total]
    @servicio = statstotal[:servicio_total]
    @egressRate = statstotal[:egressRate_total]
    @neighbor = statstotal[:neighbor_total]
    @gbpsrx = statstotal[:gbpsrx_total]
    @gbpstx = statstotal[:gbpstx_total]
    @deviceindex = statstotal[:deviceindex_total]
    if statstotal[:status_total] > 100.00
      @status = 100.00
      @bps_max = @egressRate
    else
      @bps_max = statstotal[:bps_max_total]
      @status = statstotal[:status_total]
    end

      Ppminterfaceinternet.last.ppminterfaceinternets_array.map do |crecimiento|
        if crecimiento[:deviceindex] == @deviceindex
          if ((crecimiento[:comment]) != 0) and ((crecimiento[:comment]) != nil)
            @comment = crecimiento[:comment]
          else  
            @comment = '-'
          end
          if ((crecimiento[:time]) != 0) and ((crecimiento[:time]) != nil)
            @time = crecimiento[:time]
          else  
            @time = '-'
          end          
          if (crecimiento[:status]) != 0
            @last_status = crecimiento[:status]
            @last_bps_max = crecimiento[:bps_max]
            @crecimiento = (((@status - @last_status)/@last_status) * 100.00).round(2)          
          else
            @crecimiento = 0
            @last_bps_max = 0
            @last_status = 0
          end
          break
        else
          @crecimiento = 0
          @last_bps_max = 0
          @last_status = 0
        end
      end
      hash = Hash[device: @device, 
                  port: @port, 
                  servicio: @servicio, 
                  gbpsrx: @gbpsrx, 
                  gbpstx: @gbpstx, 
                  bps_max: @bps_max, 
                  last_bps_max: @last_bps_max, 
                  last_status: @last_status, 
                  crecimiento: @crecimiento, 
                  status: @status, 
                  egressRate: @egressRate, 
                  neighbor: @neighbor, 
                  comment: @comment, 
                  time: @time, 
                  deviceindex: @deviceindex]
      tablecrecimiento << hash
   end
   return tablecrecimiento.sort! { |a,b| b[:status] <=> a[:status] }
  end

end
