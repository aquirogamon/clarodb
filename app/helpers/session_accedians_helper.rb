module SessionAccediansHelper

	def self.devint
	  CSV.read(Rails.root + "public/accedian.csv")[1..-1]
	end
	def self.change_ip_reflector(name_equipo,actuador, new_ip_endpoint)

	  devint.select{|localidad| localidad[1] == actuador}.map{|localidad| 
	     @name_session_af12 = localidad[2] + "_" + name_equipo + "_AF12"
	     @name_session_ef = localidad[2] + "_" + name_equipo + "_EF"
	     @name_accedian = localidad[1]
	  }
	  url_session_action_af12 = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/" + @name_session_af12 + "/operate"
	  url_session_action_ef = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/" + @name_session_ef + "/operate"
	  url_endpoint_action = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/endpoint/"+ name_equipo + "/operate"
	  url_ip_change_endpoint = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/endpoint/reflector/"+ name_equipo + "/address"
	  url_ip_change_endpoint_twamp = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/endpoint/reflector/"+ name_equipo + "/twampcp"

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
	  data_action_resolve = {
	    "action":"resolve"
	  }

	  data_change_ip_endpoint = {
	    "ip"=>new_ip_endpoint
	  }

	  data_change_ip_endpoint_twamp = {
	    "address"=>new_ip_endpoint
	  }

	  RestClient::Request.execute(
	    :url => url_session_action_af12, 
	    :method => :put, 
	    :headers => headers,
	    :payload => data_action_stop.to_json,
	    :verify_ssl => false
	  )
	  RestClient::Request.execute(
	    :url => url_session_action_af12, 
	    :method => :put, 
	    :headers => headers,
	    :payload => data_action_terminated.to_json,
	    :verify_ssl => false
	  )
	  RestClient::Request.execute(
	    :url => url_session_action_ef, 
	    :method => :put, 
	    :headers => headers,
	    :payload => data_action_stop.to_json,
	    :verify_ssl => false
	  )
	  RestClient::Request.execute(
	    :url => url_session_action_ef, 
	    :method => :put, 
	    :headers => headers,
	    :payload => data_action_terminated.to_json,
	    :verify_ssl => false
	  )

	  RestClient::Request.execute(
	    :url => url_endpoint_action, 
	    :method => :put, 
	    :headers => headers,
	    :payload => data_action_terminated.to_json,
	    :verify_ssl => false
	  )

	  RestClient::Request.execute(
	    :url => url_ip_change_endpoint, 
	    :method => :put, 
	    :headers => headers,
	    :payload => data_change_ip_endpoint.to_json,
	    :verify_ssl => false
	  )

	  RestClient::Request.execute(
	    :url => url_ip_change_endpoint_twamp, 
	    :method => :put, 
	    :headers => headers,
	    :payload => data_change_ip_endpoint_twamp.to_json,
	    :verify_ssl => false
	  )
	  RestClient::Request.execute(
	    :url => url_endpoint_action, 
	    :method => :put, 
	    :headers => headers,
	    :payload => data_action_resolve.to_json,
	    :verify_ssl => false
	  )

	  RestClient::Request.execute(
	    :url => url_session_action_af12, 
	    :method => :put, 
	    :headers => headers,
	    :payload => data_action_start.to_json,
	    :verify_ssl => false
	  )
	  RestClient::Request.execute(
	    :url => url_session_action_ef, 
	    :method => :put, 
	    :headers => headers,
	    :payload => data_action_start.to_json,
	    :verify_ssl => false
	  )
	end

	def self.restart_id_session(name_session)

	  url_session_action = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/" + name_session + "/operate"

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

	  RestClient::Request.execute(
	    :url => url_session_action, 
	    :method => :put, 
	    :headers => headers,
	    :payload => data_action_stop.to_json,
	    :verify_ssl => false
	  )
	  RestClient::Request.execute(
	    :url => url_session_action, 
	    :method => :put, 
	    :headers => headers,
	    :payload => data_action_terminated.to_json,
	    :verify_ssl => false
	  )
	  RestClient::Request.execute(
	    :url => url_session_action, 
	    :method => :put, 
	    :headers => headers,
	    :payload => data_action_start.to_json,
	    :verify_ssl => false
	  )
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
	for i in(1..1000)
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
	for i in(1..5000)
	end
	table_id_session_error.each do |id|
		id_session = id
		SessionAccedian.id_session_detail(id_session)
	end
	end

end
