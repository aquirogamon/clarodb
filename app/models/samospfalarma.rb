class Samospfalarma < ActiveRecord::Base

  serialize :samospfalarmas_array

  require 'rest-client'
  require 'json'
  require 'open-uri'
  require 'csv'

  def self.ospfstats_summary
   xml = File.read("#{Rails.root}/public/fm.AlarmObject.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)
   return data_parsed
  end

  def self.table_probableCause
    scalabilitynokia_array = CSV.read(Rails.root + "public/table_probableCause.csv")
  end

  def self.samospfalarma_table
   table = Array.new []
   data_stats = ospfstats_summary['Envelope']['Body']['findResponse']['result']['fm.AlarmObject']
   
   data_stats.map do |stats_device|
    @nodeName = stats_device["nodeName"]
    @affectedObjectDisplayedName = stats_device["affectedObjectDisplayedName"]
    @affectedObjectClassName = stats_device["affectedObjectClassName"]
    @affectedObjectFullName = stats_device["affectedObjectFullName"]
    @name = stats_device["name"]
    @numberOfOccurences = stats_device["numberOfOccurences"]
    timefirts_unix = (stats_device["firstTimeDetected"]).to_i/1000
    @timefirts = Time.at(timefirts_unix).strftime("%B %e, %Y at %I:%M %p")
    timelast_unix = (stats_device["lastTimeDetected"]).to_i/1000
    @timelast = Time.at(timelast_unix).strftime("%B %e, %Y at %I:%M %p")
    @alarmClassTag = stats_device["alarmClassTag"]
    probableCause_index = stats_device["probableCause"]
    @rangetime = (timelast_unix - timefirts_unix)

    table_probableCause.map do |probableCause|
     if probableCause[0] == probableCause_index
      @probableCause = probableCause[1]
      break
     else
      @probableCause = '-'
     end
    end

     hash = Hash[nodeName: @nodeName, affectedObjectDisplayedName: @affectedObjectDisplayedName, affectedObjectFullName: @affectedObjectFullName, affectedObjectClassName: @affectedObjectClassName, name: @name, timefirts: @timefirts, timefirts_unix: @timefirts_unix, timelast: @timelast, alarmClassTag: @alarmClassTag, probableCause: @probableCause, rangetime: @rangetime, numberOfOccurences: @numberOfOccurences]
     table << hash

    end
    return table.sort! { |a,b| b[:numberOfOccurences] <=> a[:numberOfOccurences] }
  end

end