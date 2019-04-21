class Ppmredcorporativainterface < ActiveRecord::Base

  serialize :ppmredcorporativainterfaces_array

  require 'rest-client'
  require 'json'
  require 'csv'

  def self.transport_stats(ip_address)
    fqdn = '&FQDN=Node%3D' + ip_address
    #base_url = "https://aquiroga:Cl4r0peru51@172.19.212.8:4440/ppm/rest/reports/Transport+Statistics/Interface/Interface+Utilization%2FBit+Rates?outputType=jsonv2&durationSelect=lastDay&intervalTypeKey=HOUR&maxPageSize=200000" + fqdn
    base_url = "https://aquiroga:Cl4r0peru51@172.19.212.8:4440/ppm/rest/reports/Transport+Statistics/Interface/Interface+Utilization%2FBit+Rates?outputType=jsonv2&durationSelect=last3Days&intervalTypeKey=QUARTER_HOUR&maxPageSize=200000" + fqdn
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
    redcorporativainterface_array = CSV.read(Rails.root + "public/redcorporativa.csv")[1..-1]
  end

  def self.host
    csv_data = CSV.read(Rails.root + "public/redcorporativa.csv")

    keys = Array.new []
    headers = csv_data.shift.map {|i| i.to_s }
    string_data = csv_data.map {|row| row.map {|cell| cell.to_s } }
    array_of_hashes = string_data.map {|row| Hash[*headers.zip(row).flatten] }
    grouped  = array_of_hashes.group_by {|h| h["Host"]}
    keys = grouped.keys.zip
  end

  def self.calculator_percentile(arr, key)
   values_sorted = arr.map { |g| g[key] }.sort
   k = (0.95*(values_sorted.length-1)+1).floor - 1
   f = (0.95*(values_sorted.length-1)+1).modulo(1)
   return values_sorted[k] + (f * (values_sorted[k+1] - values_sorted[k]))
  end

  def self.statsinterfacetotal_table
   
   tabletotal = Array.new []
   host.map do |host_key|
    @hosttotal = host_key[0]
    data_stats = Hash.new { |hash, key| hash[key] = [] }
    data_stats = transport_stats(@hosttotal)
      data_stats.map do |stats_device|
          @gbpsrxtotal = ((stats_device[8].gsub(/,/, '').to_f)/1000000000).round(2)
          @gbpstxtotal = ((stats_device[7].gsub(/,/, '').to_f)/1000000000).round(2)
          @egressRatetotalppm = (stats_device[4].gsub(/,/, '').to_i)/1000000000
          @indextotal = stats_device[3]
          #hostindextotal = hosttotal+indextotal
          porttotal = stats_device[0]
          deviceppm.map do |deviceppm|
            @hostppmtotal = deviceppm[1]
            if @hostppmtotal == @hosttotal
              @devicetotal = deviceppm[0]
              @deviceindextotal = (@devicetotal + @indextotal).to_s
            devinternet.map do |devinternet|
             @hostindexdevice = (devinternet[4]).to_s
             if @deviceindextotal == @hostindexdevice
              @device = (devinternet[0]).to_s
              hash = Hash[device: @device, porttotal: porttotal, serviciototal: devinternet[3], gbpsrxtotal: @gbpsrxtotal, gbpstxtotal: @gbpstxtotal, egressRatetotalppm: @egressRatetotalppm, deviceindextotal: @deviceindextotal]
              tabletotal << hash
             end
            end
            end
          end
      end
   end
  #return tabletotal.flatten.group_by{ |x| x[:deviceindextotal] }.values.map{ |gp| gp.max_by{ |st| st[:statustotal] }}
  return tabletotal.flatten.group_by { |g| g[:deviceindextotal] }.
      map { |k,v| { :deviceindextotal=>k, :device=>v.first[:device], :porttotal=>v.first[:porttotal], :serviciototal=>v.first[:serviciototal], :egressRatetotalppm=>v.first[:egressRatetotalppm],
        :gbpsrxtotal_per=>calculator_percentile(v, :gbpsrxtotal), :gbpstxtotal_per=>calculator_percentile(v, :gbpstxtotal) } }
  end

  def self.statsinterfacecrecimiento_table
   
   tablecrecimiento = Array.new []
   statsinterfacetotal_table.map do |percentiletotal|
    @device_crecimiento = percentiletotal[:device]
    @port_crecimiento = percentiletotal[:porttotal]
    @servicio_crecimiento = percentiletotal[:serviciototal]
    @gbpsrx_crecimiento = percentiletotal[:gbpsrxtotal_per].round(2)
    @gbpstx_crecimiento = percentiletotal[:gbpstxtotal_per].round(2)
    @egressRate_crecimiento = percentiletotal[:egressRatetotalppm]
    @deviceindextotal_crecimiento = percentiletotal[:deviceindextotal]
    @status_rx = ((@gbpsrx_crecimiento / @egressRate_crecimiento) * 100.00 ).round(2)
    @status_tx = ((@gbpstx_crecimiento / @egressRate_crecimiento) * 100.00 ).round(2)

    Ppmredcorporativainterface.last.ppmredcorporativainterfaces_array.map do |crecimiento|
      if crecimiento[:deviceindextotal_crecimiento] == @deviceindextotal_crecimiento
        if ((crecimiento[:status_rx]) != 0) && ((crecimiento[:status_tx]) != 0)       
          @crecimiento_rx = (((@status_rx - crecimiento[:status_rx])/crecimiento[:status_rx]) * 100.00).round(2)
          @crecimiento_tx = (((@status_tx - crecimiento[:status_tx])/crecimiento[:status_tx]) * 100.00).round(2)
          @last_statusrx = crecimiento[:status_rx]
          @last_statustx = crecimiento[:status_tx]
          @last_crecimiento = crecimiento[:crecimiento]
          #@crecimientototal = crecimiento[:statustotal]
          if @crecimiento_rx > @crecimiento_tx
            @crecimiento = @crecimiento_rx
          else
            @crecimiento = @crecimiento_tx
          end
          break
        else
          @crecimiento_rx = 0
          @crecimiento_tx = 0
          @crecimiento = 0
        end
      else
        @crecimiento_rx = 0
        @crecimiento_tx = 0
        @crecimiento = 0
      end
    end
      
   hash = Hash[device_crecimiento: @device_crecimiento, 
                port_crecimiento: @port_crecimiento, 
                servicio_crecimiento: @servicio_crecimiento, 
                gbpsrx_crecimiento: @gbpsrx_crecimiento, 
                gbpstx_crecimiento: @gbpstx_crecimiento, 
                crecimiento: @crecimiento, 
                crecimiento_rx: @crecimiento_rx, 
                crecimiento_tx: @crecimiento_tx, 
                egressRate_crecimiento: @egressRate_crecimiento, 
                status_rx: @status_rx, 
                status_tx: @status_tx, 
                last_statusrx: @last_statusrx, 
                last_statustx: @last_statustx, 
                last_crecimiento: @last_crecimiento, 
                deviceindextotal_crecimiento: @deviceindextotal_crecimiento]
   tablecrecimiento << hash
   end
   return tablecrecimiento.flatten.sort! { |a,b| b[:crecimiento] <=> a[:crecimiento] }
  end


end
