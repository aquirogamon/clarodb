json.array!(@cacheakamai_interfaces) do |cacheakamai_interface|
  json.extract! cacheakamai_interface, :id, :device, :port, :nodo, :gbpsrx, :gbpstx, :bps_max, :status, :last_bps_max, :last_status, :crecimiento, :egressRate, :time, :comment, :deviceindex
  json.url cacheakamai_interface_url(cacheakamai_interface, format: :json)
end
