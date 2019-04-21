json.array!(@cacheudni_interfaces) do |cacheudni_interface|
  json.extract! cacheudni_interface, :id, :device, :port, :nodo, :gbpsrx, :gbpstx, :bps_max, :status, :last_bps_max, :last_status, :crecimiento, :egressRate, :time, :comment, :deviceindex
  json.url cacheudni_interface_url(cacheudni_interface, format: :json)
end
