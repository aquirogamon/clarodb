class SessionAccedian < ActiveRecord::Base

  def self.device_sam
   xml = File.read("#{Rails.root}/public/Element.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)
   return data_parsed['Envelope']['Body']['findResponse']['result']['netw.NetworkElement']
  end

  def self.all_vcxs
    base_url = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/endpoint"
    data = RestClient::Request.execute(:url => base_url, :method => :get, :verify_ssl => false)
    data_parsed_vcx = Hash.from_xml(data)['endpointHeads']['EndpointHead'].select{|interfaces| interfaces["name"].include?("VCX")}.map{|vcx_name|
      name_all_vcx = vcx_name["name"]
    }
    return data_parsed_vcx
  end
  def self.id_vcx(id_vcx)
    endpoint = '/' + id_vcx
    base_url = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/endpoint/supervision" + endpoint
    data = RestClient::Request.execute(:url => base_url, :method => :get, :verify_ssl => false)
    data_parsed_interface = Hash.from_xml(data)['Endpoint']
    return data_parsed_interface
  end
  def self.detail_vcx
    table_all_vcx_detail = Array.new []
    table_all_vcx = all_vcxs

    table_all_vcx.each do |vcx_id|
      table_detail_vcx = id_vcx(vcx_id)
      name_vcx = table_detail_vcx["name"]
      gestion_vcx = table_detail_vcx["ip"]
      state_vcx = table_detail_vcx["state"]
      product_accedian = table_detail_vcx["product"]
      array_interface_vcx = table_detail_vcx["Interfaces"]["Interface"].select{|vcx_interface| vcx_interface["name"].include?("Traffic")}.map{|vcx_interface|
        interface_vcx = vcx_interface["name"]
        ip_interface_vcx = vcx_interface["IpAddresses"]["IpAddress"]["ip"]
        device_interface_vcx = name_vcx + interface_vcx
        hash = Hash[name_vcx: name_vcx, interface_vcx: interface_vcx, ip_interface_vcx: ip_interface_vcx, device_interface_vcx: device_interface_vcx]
        table_all_vcx_detail << hash
      }
    end
    return table_all_vcx_detail
  end

  def self.ip_url_opm
    CSV.read(Rails.root + "public/ip_opm_tip_key.csv")
  end
  def self.all_devices(id_name_endpoint)
    table = Array.new []
    url_all_device = "http://172.19.216.78:8000/api/json/device/listDevices?apiKey=03765800ce85e7bbe4f0771bc391b323"
    data_all_device = RestClient::Request.execute(:url => url_all_device , :method => :get)
    data_parsed = JSON.load(data_all_device).select{|device_ip| device_ip["displayName"] == id_name_endpoint}.map{
      |device_ip| ip_address = device_ip["ipaddress"]
    }
    return data_parsed[0]
  end
  def self.status_devices(ip_name_endpoint)
    url_ip_device = "http://172.19.216.78:8000/api/json/device/getInterfaces?apiKey=03765800ce85e7bbe4f0771bc391b323&name=" + ip_name_endpoint
    data_status_device = RestClient::Request.execute(:url => url_ip_device , :method => :get)
    hash_device = {"message"=>"No Devices found."}
    if JSON.load(data_status_device) == hash_device
      data_parsed_device = "No Devices found."
    else
      data_parsed_device = JSON.load(data_status_device).select{|interfaces| interfaces["displayName"].include?("gestion")}.map{
        |interfaces| status_device = interfaces["statusStr"]
      }[0]
    end
    return data_parsed_device
  end
  def self.all_devices_opm
    table_devices = Array.new []
    ip_url_opm.map do |url_key|
      url = url_key[0]
      key = url_key[1]
      url_all_device = url + "/api/json/device/listDevices?apiKey=" + key
      data_all_device = RestClient::Request.execute(:url => url_all_device , :method => :get)
      data_parsed = JSON.load(data_all_device)
      data_parsed.map do |device_ip|
        ip_address = device_ip["ipaddress"]
        displayName = device_ip["displayName"]
        statusStr = device_ip["statusStr"]
        hash = Hash[ip_address: ip_address, displayName: displayName, url: url, key: key, statusStr: statusStr]
        table_devices << hash
      end
    end
    return table_devices
  end
  def self.status_all_device
    table_devices_status = Array.new []
    table_all_device = all_devices_opm
    table_all_device.map do |device_all|
      device = device_all[:displayName]
      ip_device = device_all[:ip_address]
      status_device = status_devices(ip_device)
      hash = Hash[device: device, ip_device: ip_device, status_device: status_device]
      table_devices_status << hash
    end
    return table_devices_status
  end

  # Exportamos todos los endpoint creados
  def self.all_endpoints
    base_url = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/endpoint"
    data = RestClient::Request.execute(:url => base_url, :method => :get, :verify_ssl => false)
    data_parsed = Hash.from_xml(data)['endpointHeads']['EndpointHead']
    return data_parsed
  end
  # Exportamos la configuración de un endpoint
  def self.id_endpoint(name_endpoint)
    endpoint = '/' + name_endpoint
    base_url = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/endpoint/reflector" + endpoint
    data = RestClient::Request.execute(:url => base_url, :method => :get, :verify_ssl => false)
    data_parsed = Hash.from_xml(data)['Endpoint']
    return data_parsed
  end

  # Exportamos todos los session creados
  def self.all_sessions
    base_url = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session"
    data = RestClient::Request.execute(:url => base_url, :method => :get, :verify_ssl => false)
    data_parsed = Hash.from_xml(data)['sessionHeads']['SessionHead']
    return data_parsed
  end
  # Exportamos la configuración de un session
  def self.id_session(name_session)
    session = '/' + name_session
    base_url = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/twamp" + session
    data = RestClient::Request.execute(:url => base_url, :method => :get, :verify_ssl => false)
    data_parsed = Hash.from_xml(data)['TwampSession']
    return data_parsed
  end

  # Exportamos todos los SLA creados
  def self.all_slas
    base_url = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/sla"
    data = RestClient::Request.execute(:url => base_url, :method => :get, :verify_ssl => false)
    data_parsed = Hash.from_xml(data)['slas']['Sla']
    return data_parsed
  end
  # Exportamos las sesiones de cada SLA
  def self.id_sla(name_sla)
    base_url = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/sla/" + name_sla + "/session"
    data = RestClient::Request.execute(:url => base_url, :method => :get, :verify_ssl => false)
    if Hash.from_xml(data)['sessionRefs'] != nil
      data_parsed = Hash.from_xml(data)['sessionRefs']["SessionRef"]
    end
    return data_parsed
  end
  def self.all_sessions_sla

    table_all_session_sla = Array.new []
    table_all_sla = all_slas

    table_all_sla.map do |allsla|
      name_sla_all = allsla["name"]
      table_sla_session = id_sla(name_sla_all)
      if table_sla_session != nil
      table_sla_session.map do |slasession|
        name_sla_session_all = slasession["name"]
        hash = Hash[name_sla_all: name_sla_all, name_sla_session_all: name_sla_session_all]
        table_all_session_sla << hash
      end
      end
    end
    return table_all_session_sla
  end

  def self.all_sessions_detail
    
    SessionAccedian.delete_all
    table_all_session_detail = Array.new []
    table_all_session = all_sessions
    table_all_endpoint = all_endpoints
    table_all_sla_session = all_sessions_sla
    table_all_status_device = device_sam

    table_all_session.map do |allsession|
      name_session = allsession["name"]
      sessionType = allsession["sessionType"]
      dstEndpoint = allsession["receiverNodeName"]
      srcEndpoint = allsession["senderNodeName"]
      state_session = allsession["state"]

      table_id_session = id_session(name_session)
      dstPort = table_id_session["dstPort"]
      srcPort = table_id_session["srcPort"]
      srcIfc = table_id_session["srcIfc"]
      state_session = table_id_session["state"]
      interval_session = table_id_session["interval"]
      tos_session = table_id_session["tos"]
      payloadsize_session = table_id_session["Stream"]["payloadsize"]
      pps_session = table_id_session["Stream"]["pps"]
      type_port = table_id_session["Stream"]["type"]

      table_all_endpoint.select{|allendpoint| dstEndpoint == allendpoint["name"]}.map{|allendpoint|
        name_endpoint = allendpoint["name"]
        ip_endpoint = allendpoint["ip"]
        product_endpoint = allendpoint["product"]
        type_endpoint = allendpoint["type"]
        state_endpoint = allendpoint["state"]

        table_all_id_endpoint = id_endpoint(name_endpoint)
        capability = table_all_id_endpoint["Capabilities"]["capability"]["cap"]
        port_endpoint = table_all_id_endpoint["TwampCp"]["port"]
        tos_endpoint = table_all_id_endpoint["TwampCp"]["tos"]

        array_sla = table_all_sla_session.select{|idsla| name_session == idsla[:name_sla_session_all]}
        if array_sla != []
					array_sla.map{|idsla|
						@sla = idsla[:name_sla_all]
				}
				else
				  @sla = "Sin_SLA"
				end

        array_status = table_all_status_device.select{|status| name_endpoint == status[:displayName]}
        if array_status != []
          array_status.map{|status|
            @status_device = status[:statusStr]
        }
        else
          @status_device = "Device Not Monitored"
        end

          hash = Hash[ip_endpoint: ip_endpoint, product_endpoint: product_endpoint, type_endpoint: type_endpoint, 
            state_endpoint: state_endpoint, name_session: name_session, sessionType: sessionType, 
            dstEndpoint: dstEndpoint, srcEndpoint: srcEndpoint, state_session: state_session, sla: @sla, 
            srcPort: srcPort, dstPort: dstPort, srcIfc: srcIfc, 
            interval_session: interval_session, tos_session: tos_session, 
            capability: capability, port_endpoint: port_endpoint, tos_endpoint: tos_endpoint, 
            payloadsize_session: payloadsize_session, pps_session: pps_session, type_port: type_port, status_device: @status_device]
          table_all_session_detail << hash
      }
    end

    return table_all_session_detail.sort_by { |a| [ a[:product_endpoint], a[:srcEndpoint], a[:state_session] ] }
  end

  def self.all_sessions_endpoint
    
    SessionAccedian.delete_all
    table_all_session_detail = Array.new []
    table_all_session = all_sessions
    table_all_endpoint = all_endpoints
    table_all_sla_session = all_sessions_sla
    table_all_status_device = device_sam

    table_all_session.map do |allsession|
      name_session = allsession["name"]
      sessionType = allsession["sessionType"]
      dstEndpoint = allsession["receiverNodeName"]
      srcEndpoint = allsession["senderNodeName"]
      state_session = allsession["state"]

      table_all_endpoint.select{|allendpoint| dstEndpoint == allendpoint["name"]}.map{|allendpoint|
        name_endpoint = allendpoint["name"]
        ip_endpoint = allendpoint["ip"]
        product_endpoint = allendpoint["product"]
        type_endpoint = allendpoint["type"]
        state_endpoint = allendpoint["state"]

        array_sla = table_all_sla_session.select{|idsla| name_session == idsla[:name_sla_session_all]}
        if array_sla != []
					array_sla.map{|idsla|
						@sla = idsla[:name_sla_all]
				}
				else
				  @sla = "Sin_SLA"
				end

        array_status = table_all_status_device.select{|status| name_endpoint == status["displayedName"]}
        if array_status != []
          array_status.map{|status|
            @status_device = status["reachability"]
        }
        else
          @status_device = "Device Not Monitored"
        end


          hash = Hash[ip_endpoint: ip_endpoint, product_endpoint: product_endpoint, type_endpoint: type_endpoint, 
            state_endpoint: state_endpoint, name_session: name_session, sessionType: sessionType, 
            dstEndpoint: dstEndpoint, srcEndpoint: srcEndpoint, state_session: state_session, sla: @sla, status_device: @status_device]
          table_all_session_detail << hash
      }
    end

    #return table_all_session_detail.sort! { |a,b| b[:srcEndpoint] <=> a[:srcEndpoint] }
    return table_all_session_detail.sort_by { |a| [ a[:product_endpoint], a[:srcEndpoint], a[:state_session] ] }
  end


  private
  # Exportamos la configuración de un session
  def self.id_session_detail(id_params_session)
  	id_name_session = SessionAccedian.find(id_params_session).name_session
    id_name_endpoint = SessionAccedian.find(id_params_session).dstEndpoint

    table_id_session_detail = id_session(id_name_session)
    table_id_endpoint_detail = id_endpoint(id_name_endpoint)
    table_detail_vcx = detail_vcx

    dstPort = table_id_session_detail["dstPort"]
    srcPort = table_id_session_detail["srcPort"]
    srcIfc = table_id_session_detail["srcIfc"]
    state_session = table_id_session_detail["state"]
    interval_session = table_id_session_detail["interval"]
    tos_session = table_id_session_detail["tos"]
    payloadsize_session = table_id_session_detail["Stream"]["payloadsize"]
    pps_session = table_id_session_detail["Stream"]["pps"]
    type_port = table_id_session_detail["Stream"]["type"]

    srcEndpoint = table_id_session_detail["srcEndpoint"]
    srcIfc = table_id_session_detail["srcIfc"]
    device_interface = srcEndpoint + srcIfc

    ip_endpoint = table_id_endpoint_detail["ip"]
    state_endpoint = table_id_endpoint_detail["state"]
    capability = table_id_endpoint_detail["Capabilities"]["capability"]["cap"]
    port_endpoint = table_id_endpoint_detail["TwampCp"]["port"]
    tos_endpoint = table_id_endpoint_detail["TwampCp"]["tos"]

    table_detail_vcx.select{|interface_vcx| device_interface == interface_vcx[:device_interface_vcx]}.map{|interface_vcx| 
      @ip_interface_vcx = interface_vcx[:ip_interface_vcx]
    }

    SessionAccedian.find(id_params_session).update(dstPort: dstPort, srcPort: srcPort, srcIfc: srcIfc, state_session: state_session, 
    																			interval_session: interval_session, tos_session: tos_session, payloadsize_session: payloadsize_session,
    																			pps_session: pps_session, type_port: type_port, state_endpoint: state_endpoint, 
                                          capability: capability, port_endpoint: port_endpoint, tos_endpoint: tos_endpoint,
                                          ip_endpoint: ip_endpoint, ip_interface_vcx: @ip_interface_vcx )

  end



  def self.restart_waiting_session

  table_name_session_waiting = SessionAccedian.where(state_session: "Waiting").pluck(:name_session)
  table_id_session_waiting = SessionAccedian.where(state_session: "Waiting").pluck(:id)

  headers = {
  :content_type => "application/json"
  }
  data_action_stop = {
  "action":"stop"
  }
  data_action_terminated = {
  "action":"terminate"
  }
  data_action_start = {
  "action":"start"
  }
  table_name_session_waiting.each do |session|
  name_session = session
  url_session_action = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/" + name_session + "/operate"
  RestClient::Request.execute(
    :url => url_session_action, 
    :method => :put, 
    :headers => headers,
    :payload => data_action_terminated.to_json,
    :verify_ssl => false
  )
  end
  for i in(1..10000)
  end
  table_name_session_waiting.each do |session|
  name_session = session
  url_session_action = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/" + name_session + "/operate"
  RestClient::Request.execute(
    :url => url_session_action, 
    :method => :put, 
    :headers => headers,
    :payload => data_action_start.to_json,
    :verify_ssl => false
  )
  end
  for i in(1..10000)
  end
  table_id_session_waiting.each do |id|
    id_session = id
    SessionAccedian.id_session_detail(id_session)
  end
  end

  def self.restart_error_session

  table_name_session_error = SessionAccedian.where(state_session: "Error").pluck(:name_session)
  table_id_session_error = SessionAccedian.where(state_session: "Error").pluck(:id)


  headers = {
  :content_type => "application/json"
  }
  data_action_stop = {
  "action":"stop"
  }
  data_action_terminated = {
  "action":"terminate"
  }
  data_action_start = {
  "action":"start"
  }
  table_name_session_error.each do |session|
  name_session = session
  url_session_action = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/" + name_session + "/operate"
    RestClient::Request.execute(
    :url => url_session_action, 
    :method => :put, 
    :headers => headers,
    :payload => data_action_terminated.to_json,
    :verify_ssl => false
  )
  end
  for i in(1..10000)
  end
  table_name_session_error.each do |session|
  name_session = session
  url_session_action = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/" + name_session + "/operate"
    RestClient::Request.execute(
    :url => url_session_action, 
    :method => :put, 
    :headers => headers,
    :payload => data_action_start.to_json,
    :verify_ssl => false
  )
  end
  for i in(1..10000)
  end
  table_id_session_error.each do |id|
    id_session = id
    SessionAccedian.id_session_detail(id_session)
  end
  end

  def self.start_session_terminated_router

  table_name_session_terminated = SessionAccedian.where(state_session: "Terminated").where("name_session NOT LIKE ?", "%4G%").pluck(:name_session)
  table_id_session_terminated = SessionAccedian.where(state_session: "Terminated").where("name_session NOT LIKE ?", "%4G%").pluck(:id)


  headers = {
  :content_type => "application/json"
  }
  data_action_stop = {
  "action":"stop"
  }
  data_action_terminated = {
  "action":"terminate"
  }
  data_action_start = {
  "action":"start"
  }
  for i in(1..10000)
  end
  table_name_session_terminated.each do |session|
  name_session = session
  url_session_action = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/" + name_session + "/operate"
    RestClient::Request.execute(
    :url => url_session_action, 
    :method => :put, 
    :headers => headers,
    :payload => data_action_start.to_json,
    :verify_ssl => false
  )
  end
  for i in(1..10000)
  end
  table_id_session_terminated.each do |id|
    id_session = id
    id_session_detail(id_session)
  end
  end

  def self.start_session_terminated_4G

  table_name_session_terminated = SessionAccedian.where(state_session: "Terminated").where("name_session LIKE ?", "%4G%").pluck(:name_session)
  table_id_session_terminated = SessionAccedian.where(state_session: "Terminated").where("name_session LIKE ?", "%4G%").pluck(:id)


  headers = {
  :content_type => "application/json"
  }
  data_action_stop = {
  "action":"stop"
  }
  data_action_terminated = {
  "action":"terminate"
  }
  data_action_start = {
  "action":"start"
  }
  for i in(1..10000)
  end
  table_name_session_terminated.each do |session|
  name_session = session
  url_session_action = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/" + name_session + "/operate"
    RestClient::Request.execute(
    :url => url_session_action, 
    :method => :put, 
    :headers => headers,
    :payload => data_action_start.to_json,
    :verify_ssl => false
  )
  end
  for i in(1..10000)
  end
  table_id_session_terminated.each do |id|
    id_session = id
    id_session_detail(id_session)
  end
  end


def self.reload_error_session

  table_id_session_error = SessionAccedian.where(state_session: "Error").pluck(:id)

  table_id_session_error.each do |id|
  id_session = id
  id_session_detail(id_session)
  end

end


def self.reload_waiting_session

  table_id_session_waiting = SessionAccedian.where(state_session: "Waiting").pluck(:id)

  table_id_session_waiting.each do |id|
  id_session = id
  id_session_detail(id_session)
  end

end


end
