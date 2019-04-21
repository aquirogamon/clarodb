require 'csv'

namespace :import do
	desc "Import internet_interface from CSV"

	task internet_interface: :environment do
		filename = File.join Rails.root, "interfaceinternet_1.csv"
		CSV.foreach(filename) do |row|
			device, port, servicio, egressRate, neighbor, last_bps_max, last_status, bps_max, status, crecimiento, comment, time, deviceindex, gbpsrx, gbpstx, created_at = row
			InternetInterface.create(device: device, port: port, servicio: servicio, egressRate: egressRate, neighbor: neighbor, last_bps_max: last_bps_max, last_status: last_status, bps_max: bps_max, status: status, crecimiento: crecimiento, comment: comment, time: time, deviceindex: deviceindex, gbpsrx: gbpsrx, gbpstx: gbpstx, created_at: created_at)
		end
	end
end

namespace :import do
	desc "Import core_interface from CSV"

	task core_interface: :environment do
		filename = File.join Rails.root, "coreinterface.csv"
		CSV.foreach(filename) do |row|
			device, port, servicio, egressRate, last_bps_max, last_status, bps_max, status, crecimiento, comment, time, deviceindex, gbpsrx, gbpstx, created_at = row
			CoreInterface.create(device: device, port: port, servicio: servicio, egressRate: egressRate, last_bps_max: last_bps_max, last_status: last_status, bps_max: bps_max, status: status, crecimiento: crecimiento, comment: comment, time: time, deviceindex: deviceindex, gbpsrx: gbpsrx, gbpstx: gbpstx, created_at: created_at)
		end
	end
end

namespace :import do
	desc "Import ipranedge_interface from CSV"

	task ipranedge_interface: :environment do
		filename = File.join Rails.root, "ipranedgeinterface.csv"
		CSV.foreach(filename) do |row|
			device, port, description, egressRate, speed, gbpsrx, gbpstx, last_bps_max, last_status, bps_max, status, crecimiento, comment, time, deviceindex, created_at = row
			IpranedgeInterface.create(device: device, port: port, description: description, egressRate: egressRate, speed: speed, gbpsrx: gbpsrx, gbpstx: gbpstx, last_bps_max: last_bps_max, last_status: last_status, bps_max: bps_max, status: status, crecimiento: crecimiento, comment: comment, time: time, deviceindex: deviceindex, created_at: created_at)
		end
	end
end

namespace :import do
	desc "Import ipranaccess_interface from CSV"

	task ipranaccess_interface: :environment do
		filename = File.join Rails.root, "ipranaccessinterface.csv"
		CSV.foreach(filename) do |row|
			device, port, description, egressRate, speed, gbpsrx, gbpstx, last_bps_max, last_status, bps_max, status, crecimiento, comment, time, deviceindex, created_at = row
			IpranaccessInterface.create(device: device, port: port, description: description, egressRate: egressRate, speed: speed, gbpsrx: gbpsrx, gbpstx: gbpstx, last_bps_max: last_bps_max, last_status: last_status, bps_max: bps_max, status: status, crecimiento: crecimiento, comment: comment, time: time, deviceindex: deviceindex, created_at: created_at)
		end
	end
end

namespace :import do
	desc "Import access internet from CSV"

	task access_internet: :environment do
		filename = File.join Rails.root, "accessinternet.csv"
		CSV.foreach(filename) do |row|
			hfc_cgn, hfc_public, hfc_ipv6, mobile_cgn, mobile_corporate, mobile_ipv6, mobile_olo, corporate, cache_in, created_at = row
			AccessInternet.create(hfc_cgn: hfc_cgn, hfc_public: hfc_public, hfc_ipv6: hfc_ipv6, mobile_cgn: mobile_cgn, mobile_corporate: mobile_corporate, mobile_ipv6: mobile_ipv6, mobile_olo: mobile_olo, corporate: corporate, cache_in: cache_in, created_at: created_at)
		end
	end
end

namespace :import do
	desc "Import cachegoogleinterface from CSV"

	task cachegoogleinterface: :environment do
		filename = File.join Rails.root, "cachegoogleinterface.csv"
		CSV.foreach(filename) do |row|
			nodo, device, port, egressRate, last_bps_max, last_status, bps_max, status, crecimiento, comment, time, deviceindex, gbpsrx, gbpstx, created_at = row
			CachegoogleInterface.create(nodo: nodo, device: device, port: port, egressRate: egressRate, last_bps_max: last_bps_max, last_status: last_status, bps_max: bps_max, status: status, crecimiento: crecimiento, comment: comment, time: time, deviceindex: deviceindex, gbpsrx: gbpsrx, gbpstx: gbpstx, created_at: created_at)
		end
	end
end

namespace :import do
	desc "Import cachefacebookinterface from CSV"

	task cachefacebookinterface: :environment do
		filename = File.join Rails.root, "cachefacebookinterface.csv"
		CSV.foreach(filename) do |row|
			nodo, device, port, egressRate, last_bps_max, last_status, bps_max, status, crecimiento, comment, time, deviceindex, gbpsrx, gbpstx, created_at = row
			CachefacebookInterface.create(nodo: nodo, device: device, port: port, egressRate: egressRate, last_bps_max: last_bps_max, last_status: last_status, bps_max: bps_max, status: status, crecimiento: crecimiento, comment: comment, time: time, deviceindex: deviceindex, gbpsrx: gbpsrx, gbpstx: gbpstx, created_at: created_at)
		end
	end
end

namespace :import do
	desc "Import cachenetflixinterface from CSV"

	task cachenetflixinterface: :environment do
		filename = File.join Rails.root, "cachenetflixinterface.csv"
		CSV.foreach(filename) do |row|
			nodo, device, port, egressRate, last_bps_max, last_status, bps_max, status, crecimiento, comment, time, deviceindex, gbpsrx, gbpstx, created_at = row
			CachenetflixInterface.create(nodo: nodo, device: device, port: port, egressRate: egressRate, last_bps_max: last_bps_max, last_status: last_status, bps_max: bps_max, status: status, crecimiento: crecimiento, comment: comment, time: time, deviceindex: deviceindex, gbpsrx: gbpsrx, gbpstx: gbpstx, created_at: created_at)
		end
	end
end

namespace :import do
	desc "Import cacheakamaiinterface from CSV"

	task cacheakamaiinterface: :environment do
		filename = File.join Rails.root, "cacheakamaiinterface.csv"
		CSV.foreach(filename) do |row|
			nodo, device, port, egressRate, last_bps_max, last_status, bps_max, status, crecimiento, comment, time, deviceindex, gbpsrx, gbpstx, created_at = row
			CacheakamaiInterface.create(nodo: nodo, device: device, port: port, egressRate: egressRate, last_bps_max: last_bps_max, last_status: last_status, bps_max: bps_max, status: status, crecimiento: crecimiento, comment: comment, time: time, deviceindex: deviceindex, gbpsrx: gbpsrx, gbpstx: gbpstx, created_at: created_at)
		end
	end
end

namespace :import do
	desc "Import preagg_interface from CSV"

	task preagg_interface: :environment do
		filename = File.join Rails.root, "preagginterface.csv"
		CSV.foreach(filename) do |row|
			device, port, servicio, egressRate, last_bps_max, last_status, bps_max, status, crecimiento, comment, time, deviceindex, gbpsrx, gbpstx, created_at = row
			PreaggInterface.create(device: device, port: port, servicio: servicio, egressRate: egressRate, last_bps_max: last_bps_max, last_status: last_status, bps_max: bps_max, status: status, crecimiento: crecimiento, comment: comment, time: time, deviceindex: deviceindex, gbpsrx: gbpsrx, gbpstx: gbpstx, created_at: created_at)
		end
	end
end
