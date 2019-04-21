json.array!(@ipranedge_interfaces) do |ipranedge_interface|
  json.extract! ipranedge_interface, :id, :device, :port, :description, :egressRate, :speed, :gbpsrx, :gbpstx, :last_bps_max, :last_status, :bps_max, :status, :crecimiento, :time, :comment, :deviceindex
  json.url ipranedge_interface_url(ipranedge_interface, format: :json)
end
