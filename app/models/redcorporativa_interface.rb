class RedcorporativaInterface < ActiveRecord::Base

  require 'rest-client'
  require 'json'
  require 'csv'

  def self.transport_stats(ip_address)
    fqdn = '&FQDN=Node%3D' + ip_address
    #base_url = "https://aquiroga:Cl4r0peru51@172.19.212.8:4440/ppm/rest/reports/Transport+Statistics/Interface/Interface+Utilization%2FBit+Rates?outputType=jsonv2&durationSelect=lastHour&intervalTypeKey=QUARTER_HOUR&maxPageSize=200000" + fqdn
    base_url = "https://aquiroga:Cl4r0peru51@172.19.212.8:4440/ppm/rest/reports/Transport+Statistics/Interface/Interface+Utilization%2FBit+Rates?outputType=jsonv2&durationSelect=last3Days&intervalTypeKey=QUARTER_HOUR&maxPageSize=200000" + fqdn
    begin
      data = RestClient::Request.execute(:url => base_url , :method => :get, :verify_ssl => false)
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
    data_parsed = JSON.load(data)["report"]["data"]
  end

  def self.devint
    CSV.read(Rails.root + "public/redcorporativa.csv")[1..-1]
  end

  def self.calculator_percentile(values, percentile)
   values_sorted = values.sort
   k = (percentile*(values_sorted.length-1)+1).floor - 1
   f = (percentile*(values_sorted.length-1)+1).modulo(1)
   return values_sorted[k] + (f * (values_sorted[k+1] - values_sorted[k]))
  
end
  def self.statsinterfacetotal_table

    table = Hash.new { |hash, key| hash[key] = [] }
    table_total = Array.new []
    @not_found = Array.new []

    devices = Array.new []
    extra_data = Hash.new { |hash,key| hash[key] = [] }
    interfaces = Hash.new { |hash,key| hash[key] = [] }

    devint.each { 
      |a,b,c,d,e,f,g,h,i,j,k,l| interfaces[a] << [c,d.to_f]
      unless devices.include? [a,b]
        devices << [a,b]      
      end
      keystring = a + c
      extra_data[keystring] = Hash[servicio_total: e.to_s]
    }
    
    data = Hash.new { |hash, key| hash[key] = [] }

    devices.map do |device|
      data[device[0]] = transport_stats(device[1])
      data[device[0]].map do |item|
        interfaces[device[0]].map do |interface|
         if interface[0].include? item[3]
            hash1 = Hash[bps_tx: item[7].gsub(/,/, '').to_f, bps_rx: item[8].gsub(/,/, '').to_f, int_total: item[0], status_tx: item[5].gsub(/,/, '').to_f, status_rx: item[6].gsub(/,/, '').to_f, egress: item[4].gsub(/,/, '').to_f]
            keystring = (device[0].to_s + item[3].to_s).to_s
            table[keystring] << hash1
         end
        end
      end
    end

    devices.each do |device|
      interfaces[device[0]].each do |interface|
        keystring = (device[0].to_s + interface[0].to_s).to_s
        if table[keystring] != []
          maxtx = (calculator_percentile(table[keystring].map { |h| h[:bps_tx] }, 0.95)/1000000000).round(2)
          maxrx = (calculator_percentile(table[keystring].map { |h| h[:bps_rx] }, 0.95)/1000000000).round(2)
          egresstotal = ((table[keystring].sort { |a,b| a[:egress] <=> b[:egress] }.last[:egress])/1000000000).round
          maxstatustx = (((maxtx/egresstotal)) * 100.00 ).round(2)
          maxstatusrx = (((maxrx/egresstotal)) * 100.00 ).round(2)

          if maxtx > maxrx
            maxbps = maxtx
          else
            maxbps = maxrx
          end
          
          if maxstatustx > maxstatusrx
            maxstatus = maxstatustx
          else
            maxstatus = maxstatusrx
          end

          int = table[keystring].first[:int_total]

          hash2 = Hash[device_total: device[0], port_total: int, 
            gbpstx_total: maxtx, gbpsrx_total: maxrx, bps_max_total: maxbps, 
            statustx_total: maxstatustx, statusrx_total: maxstatusrx, status_total: maxstatus, 
            egressRate_total: egresstotal, servicio_total: extra_data[keystring][:servicio_total], 
            deviceindex_total: keystring]
          table_total << hash2
        end
      end
    end
    return table_total.sort! { |a,b| b[:status_total] <=> a[:status_total] }
  end

  def self.statsinterfacecrecimiento_table
   @tablecrecimiento = Array.new []
   statsinterfacetotal_table.map do |statstotal|
    device = statstotal[:device_total]
    port = statstotal[:port_total]
    servicio = statstotal[:servicio_total]
    egressRate = statstotal[:egressRate_total]
    deviceindex = statstotal[:deviceindex_total]
    gbpstx = statstotal[:gbpstx_total]
    gbpsrx = statstotal[:gbpsrx_total]
    bps_max = statstotal[:bps_max_total]
    statustx = statstotal[:statustx_total]
    statusrx = statstotal[:statusrx_total]
    status = statstotal[:status_total]

      (RedcorporativaInterface.where(RedcorporativaInterface.arel_table[:created_at].gt(RedcorporativaInterface.maximum(:created_at).to_date))).map do |crecimiento|
        if crecimiento[:deviceindex] == deviceindex
          if ((crecimiento[:comment]) != "-") and ((crecimiento[:comment]) != nil)
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
            @crecimiento_rx = (((statusrx - crecimiento[:statusrx])/crecimiento[:statusrx]) * 100.00).round(2)
            @crecimiento_tx = (((statustx - crecimiento[:statustx])/crecimiento[:statustx]) * 100.00).round(2)
          else
            @crecimiento_rx = 0
            @crecimiento_tx = 0
            @last_bps_max = 0
            @last_status = 0
          end
          break
        else
          @crecimiento_rx = 0
          @crecimiento_tx = 0
          @last_bps_max = 0
          @last_status = 0
        end
      end
       hash = Hash[device: device, 
                  port: port, 
                  servicio: servicio, 
                  gbpsrx: gbpsrx, 
                  gbpstx: gbpstx, 
                  statusrx: statusrx, 
                  statustx: statustx, 
                  bps_max: bps_max, 
                  status: status, 
                  last_bps_max: @last_bps_max, 
                  last_status: @last_status, 
                  crecimiento_rx: @crecimiento_rx, 
                  crecimiento_tx: @crecimiento_tx, 
                  egressRate: egressRate, 
                  comment: @comment, 
                  time: @time, 
                  deviceindex: deviceindex]
      @tablecrecimiento << hash
   end
   return @tablecrecimiento.sort! { |a,b| b[:status] <=> a[:status] }
  end
  
end
