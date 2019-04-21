json.array!(@redcorporativa_interfaces) do |redcorporativa_interface|
  json.extract! redcorporativa_interface, :id, :device, :port, :servicio, :gbpsrx, :gbpstx, :bps_max, :statustx, :statusrx, :status, :last_bps_max, :last_status, :crecimiento_rx, :crecimiento_tx, :egressRate, :time, :comment, :deviceindex
  json.url redcorporativa_interface_url(redcorporativa_interface, format: :json)
end
