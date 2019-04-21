json.array!(@cachegoogle_interfaces) do |cachegoogle_interface|
  json.extract! cachegoogle_interface, :id, :device, :port, :nodo, :gbpsrx, :gbpstx, :bps_max, :status, :last_bps_max, :last_status, :crecimiento, :egressRate, :time, :comment, :deviceindex
  json.url cachegoogle_interface_url(cachegoogle_interface, format: :json)
end
