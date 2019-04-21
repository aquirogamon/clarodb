json.array!(@cachefacebook_interfaces) do |cachefacebook_interface|
  json.extract! cachefacebook_interface, :id, :device, :port, :nodo, :gbpsrx, :gbpstx, :bps_max, :status, :last_bps_max, :last_status, :crecimiento, :egressRate, :time, :comment, :deviceindex
  json.url cachefacebook_interface_url(cachefacebook_interface, format: :json)
end
