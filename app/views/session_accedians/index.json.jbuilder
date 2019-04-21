json.array!(@session_accedians) do |session_accedian|
  json.extract! session_accedian, :id, :ip_endpoint, :name_endpoint, :product_endpoint, :state_endpoint, :type_endpoint, :capability, :port_endpoint, :tos_endpoint, :name_session, :sessionType, :sid, :dstEndpoint, :dstPort, :srcEndpoint, :srcIfc, :srcPort, :state_session, :interval_session, :tos_session, :payloadsize_session, :pps_session, :type_port, :sla, :status_device, :ip_interface_vcx
  json.url session_accedian_url(session_accedian, format: :json)
end
