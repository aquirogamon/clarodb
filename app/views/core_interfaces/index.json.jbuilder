json.array!(@core_interfaces) do |core_interface|
  json.extract! core_interface, :id, :device, :port, :servicio, :gbpsrx, :gbpstx, :bps_max, :status, :last_bps_max, :last_status, :crecimiento, :egressRate, :time, :comment, :deviceindex
  json.url core_interface_url(core_interface, format: :json)
end
