
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
    data_parsed = Hash.from_xml(data)['sessionRefs']["SessionRef"]
    return data_parsed
  end

  def self.all_sessions_sla

    table_all_session_sla = Array.new []
    table_all_sla = all_slas

    table_all_sla.map do |allsla|
      name_sla_all = allsla["name"]
      table_sla_session = id_sla(name_sla_all)
      table_sla_session.map do |slasession|
        name_sla_session_all = slasession["name"]
        hash = Hash[name_sla_all: name_sla_all, name_sla_session_all: name_sla_session_all]
        table_all_session_sla << hash
      end
    end
    return table_all_session_sla
  end

  def self.all_sessions_detail
    
    table_all_session_detail = Array.new []
    table_all_session = all_sessions
    table_all_endpoint = all_endpoints
    table_all_sla_session = all_sessions_sla

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

        if table_all_sla_session.select{|idsla| name_session == idsla[:name_sla_session_all]} != []
          .map{|idsla|
          sla = idsla[:name_sla_all]
        }
        else
          sla = "Sin_SLA"
        end

          hash = Hash[ip_endpoint: ip_endpoint, product_endpoint: product_endpoint, type_endpoint: type_endpoint, 
            state_endpoint: state_endpoint, name_session: name_session, sessionType: sessionType, 
            dstEndpoint: dstEndpoint, srcEndpoint: srcEndpoint, state_session: state_session, sla: sla, 
            srcPort: srcPort, dstPort: dstPort, srcIfc: srcIfc, 
            interval_session: interval_session, tos_session: tos_session, 
            capability: capability, port_endpoint: port_endpoint, tos_endpoint: tos_endpoint, 
            payloadsize_session: payloadsize_session, pps_session: pps_session, type_port: type_port]
          table_all_session_detail << hash
      }
    end

    return table_all_session_detail.sort! { |a,b| b[:srcEndpoint] <=> a[:srcEndpoint] }
  end
all_sessions_detail
