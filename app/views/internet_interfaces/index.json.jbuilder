json.array!(@internet_interfaces) do |internet_interface|
  json.extract! internet_interface, :id, :device, :port, :servicio, :gbpsrx, :gbpstx, :bps_max, :last_bps_max, :last_status, :crecimiento, :status, :egressRate, :neighbor, :time, :comment, :deviceindex
  json.url internet_interface_url(internet_interface, format: :json)
end
