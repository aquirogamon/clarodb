json.array!(@ipranaccess_interfaces) do |ipranaccess_interface|
  json.extract! ipranaccess_interface, :id, :device, :port, :description, :egressRate, :speed, :gbpsrx, :gbpstx, :last_bps_max, :last_status, :bps_max, :status, :crecimiento, :time, :comment, :deviceindex
  json.url ipranaccess_interface_url(ipranaccess_interface, format: :json)
end
