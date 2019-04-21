  require 'rest-client'
  require 'json'
  require 'csv'

  def self.transport_stats(ip_address)
    fqdn = '&FQDN=Node%3D' + ip_address
    base_url = "https://aquiroga:Cl4r0peru51@172.19.212.8:4440/ppm/rest/reports/Transport+Statistics/Interface/Interface+Bit+Rates?outputType=jsonv2&durationSelect=last3Days&intervalTypeKey=FIVE_MINUTE&maxPageSize=20000000" + fqdn
    data = RestClient::Request.execute(:url => base_url , :method => :get, :verify_ssl => false)
    data_parsed = JSON.load(data)
    return data_parsed["report"]["data"]
  end

  def self.devint
    interface_array = CSV.read(Rails.root + "public/core_xxx.csv")
  end


  def self.statsinterfacemax_table
   @tablemax = Array.new []
   devint.each do |devint|
    @egressRatemax = devint[3]
    @devicemax = devint[0]

    data_stats = Hash.new { |hash, key| hash[key] = [] }
    data_stats = transport_stats(devint[1])
    data_stats.map do |stats_device|

      @bps_rxmax = stats_device[6].gsub(/,/, '').to_f
      @bps_txmax = stats_device[5].gsub(/,/, '').to_f
      @timeCapturedmax = stats_device[1]
      @egressRatemaxppm = stats_device[4]
      @indexmax = stats_device[3]
      @portmax = stats_device[0]
      @device_int_stats_max = (@devicemax+@indexmax).to_s

      if devint[5] == @device_int_stats_max
       if @bps_rxmax > @bps_txmax
        @bps_max = @bps_rxmax
       else
        @bps_max = @bps_txmax
       end
       hash = Hash[devicemax: @devicemax, portmax: @portmax, egressRatemaxppm: @egressRatemaxppm, egressRatemax: @egressRatemax, bps_max: @bps_max, bps_rxmax: @bps_rxmax, bps_txmax: @bps_txmax, timeCapturedmax: @timeCapturedmax, device_int_stats_max: @device_int_stats_max]
       @tablemax << hash
      end
    end
   end
   grouped  = @tablemax.group_by {|h| h[:device_int_stats_max]}
   keys = grouped.keys
   arr = keys.map {|k| [k, grouped[k].max_by {|h| h[:bps_max]}]}

   table1 = Array.new []
   table2 = Array.new []
    arr.each do |traf_max|
     table1 << traf_max[1]
    end
    table1.each do |traf_max|
     table2 << traf_max[1]
    end
  end
print statsinterfacemax_table

