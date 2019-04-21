json.array!(@cachenetflix_interfaces) do |cachenetflix_interface|
  json.extract! cachenetflix_interface, :id, :device, :port, :nodo, :gbpsrx, :gbpstx, :bps_max, :status, :last_bps_max, :last_status, :crecimiento, :egressRate, :time, :comment, :deviceindex
  json.url cachenetflix_interface_url(cachenetflix_interface, format: :json)
end
