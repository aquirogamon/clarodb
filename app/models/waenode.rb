class Waenode < ActiveRecord::Base

  require 'rest-client'
  require 'json'

  @ip = "172.19.212.50"
  @port = "8080"
  body = {:stageId => {:id => 0}}
  @jsonbody = JSON.generate(body)

  def self.get_all
    base_url = "http://#{@ip}:#{@port}/wae/network/modeled/entities/node/get-all-nodes"
    r = RestClient.post base_url, @jsonbody, {:content_type => :json}
    data = JSON.load(r)
    return data
  end

end