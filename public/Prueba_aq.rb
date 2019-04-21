  require 'rest-client'
  require 'json'
  require 'open-uri'
  require 'csv'
  require 'date'

  def self.interfacestats_summary
    base_url = "https://aquiroga:Cl4r0peru51@172.19.212.8:4440/ppm/rest/reports/Transport+Statistics/Interface/Interface+Bit+Rates?outputType=jsonv2&durationSelect=last3Days&intervalTypeKey=FIVE_MINUTE&maxPageSize=20000000"
    data = RestClient::Request.execute(:url => base_url , :method => :get, :verify_ssl => false)
    data_parsed = JSON.load(data)
    return data_parsed
  end

  def self.devint
    #interface_array = CSV.read(Rails.root + "public/core_x_copia.csv")
    interface_array = CSV.read(Rails.root + "public/core_xxx.csv")
  end

  def self.interface_table_core
   @tablemax = Array.new []
   data_stats = interfacestats_summary["report"]["data"]
   
   devint.map do |devint|
    @egressRatemax = (devint[3]).to_i

     data_stats.map do |stats_device|
      @bps_rxmax = ((stats_device[7].gsub(/,/, '').to_f)/1000000000).round(2)
      @bps_txmax = ((stats_device[6].gsub(/,/, '').to_f)/1000000000).round(2)
      @timeCapturedmax = stats_device[2]
      @egressRatemaxppm = stats_device[5]


      @indexmax = stats_device[4]
      @portmax = stats_device[1]
      @devicemax = stats_device[0]
      @device_int_stats_max = (@devicemax+@indexmax).to_s

     if devint[5] == @device_int_stats_max
      if @bps_rxmax > @bps_txmax
        @bps_max = @bps_rxmax
        @utilizationmax = ((@bps_max/@egressRatemax)*100.00).round(2)
      else
        @bps_max = @bps_txmax
        @utilizationmax = ((@bps_max/@egressRatemax)*100.00).round(2)
      end

      hash = Hash[devicemax: @devicemax, portmax: @portmax, egressRatemaxppm: @egressRatemaxppm, egressRatemax: @egressRatemax, bps_max: @bps_max, utilizationmax: @utilizationmax, bps_rxmax: @bps_rxmax, bps_txmax: @bps_txmax, device_int_stats_max: @device_int_stats_max]
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
print interface_table_core
