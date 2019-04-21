class AccessInternet < ActiveRecord::Base

	before_validation :sum_values

	private 

	def sum_values 
	  self.hfc = (self.hfc_cgn + self.hfc_public + self.hfc_ipv6).round
	  self.mobile = (self.mobile_cgn + self.mobile_corporate + self.mobile_ipv6).round
	  self.total_traffic = (self.hfc + self.mobile + self.mobile_olo + self.cache_in + self.corporate).round
	  self.cache_in = (self.cache_in).round
	  self.corporate = (self.corporate).round
	  self.mobile_olo = (self.mobile_olo).round
	end

end
