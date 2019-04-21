json.array!(@preagg_interfaces) do |preagg_interface|
  json.extract! preagg_interface, :id, :device, :port, :servicio, :gbpsrx, :gbpstx, :bps_max, :status, :last_bps_max, :last_status, :crecimiento, :egressRate, :time, :comment, :deviceindex
  json.url preagg_interface_url(preagg_interface, format: :json)
end
