json.array!(@access_internets) do |access_internet|
  json.extract! access_internet, :id, :total_traffic, :hfc_cgn, :hfc_public, :hfc_ipv6, :hfc, :mobile_cgn, :mobile_corporate, :mobile_ipv6, :mobile, :mobile_olo, :corporate, :cache_in
  json.url access_internet_url(access_internet, format: :json)
end
