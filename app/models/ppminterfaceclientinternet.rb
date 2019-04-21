class Ppminterfaceclientinternet < ActiveRecord::Base

  serialize :ppminterfaceclientinternets_array

  require 'rest-client'
  require 'json'
  require 'csv'

  def self.transport_stats(ip_address)
    fqdn = '&FQDN=Node%3D' + ip_address
    base_url = "https://aquiroga:Cl4r0peru51@172.19.212.8:4440/ppm/rest/reports/Transport+Statistics/Interface/Interface+Bit+Rates?outputType=jsonv2&durationSelect=last3Days&intervalTypeKey=FIVE_MINUTE&maxPageSize=20000000" + fqdn
    begin
      data = RestClient::Request.execute(:url => base_url , :method => :get, :verify_ssl => false)
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
    data_parsed = JSON.load(data)
    return data_parsed["report"]["data"]
  end

  def self.devint
    interface_array = CSV.read(Rails.root + "public/clientinternet.csv")[1..-1]
  end


  def self.percentile(values, percentile)
   values_sorted = values.sort
   k = (percentile*(values_sorted.length-1)+1).floor - 1
   f = (percentile*(values_sorted.length-1)+1).modulo(1)
   return values_sorted[k] + (f * (values_sorted[k+1] - values_sorted[k]))
  end

  def self.statsinterfacemax_table
   @tablemax = Array.new []
   devint.each do |devint|
    @egressRatemax = ((devint[3]).to_f)*1.024
    @devicemax = devint[0]
    @clientmax = devint[4]
    @cidmax = devint[5]

    data_stats = Hash.new { |hash, key| hash[key] = [] }
    data_stats = transport_stats(devint[1])
    data_stats.map do |stats_device|

      @bps_rxmax = ((stats_device[6].gsub(/,/, '').to_f)/1000000).round(2)
      @bps_txmax = ((stats_device[5].gsub(/,/, '').to_f)/1000000).round(2)
      @timeCapturedmax = stats_device[1]
      @indexmax = stats_device[3]
      @portmax = stats_device[0]
      @device_int_stats_max = (@devicemax+@indexmax).to_s

      if devint[6] == @device_int_stats_max
       if @bps_rxmax > @bps_txmax
        @bps_max = @bps_rxmax
        @status = ((@bps_max / @egressRatemax) * 100.00 ).round(2)
       else
        @bps_max = @bps_txmax
        @status = ((@bps_max / @egressRatemax) * 100.00 ).round(2)
       end
       hash = Hash[clientmax: @clientmax, cidmax: @cidmax, egressRatemax: @egressRatemax, bps_max: @bps_max, bps_rxmax: @bps_rxmax, bps_txmax: @bps_txmax, status: @status, timeCapturedmax: @timeCapturedmax, device_int_stats_max: @device_int_stats_max]
       @tablemax << hash
      end
    end
   end

   return @tablemax.group_by { |h| h[:device_int_stats_max] }.   
      map do |_,a|
        costs = a.map { |h| h[:status] }
        imax = costs.each_index.max_by { |i| costs[i] }
        a[imax].merge(:status_per=>percentile(costs, 0.95).round(1))
      end.sort! { |a,b| b[:status] <=> a[:status] }

  end
  
end
