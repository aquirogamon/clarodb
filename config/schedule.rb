# config/schedule.rb

set :output, { error: 'log/error.log', standard: 'log/cron.log' }
set :chronic_options, :hours24 => true

env :PATH, ENV['PATH']

every :sunday, :at => '21:00' do
  rake 'new_report_ipranacceso'
end

#every :sunday, :at => '06:00' do
#  rake 'new_report_ipranqosegressacceso'
#end

every :sunday, :at => '23:00' do
  rake 'new_report_ipranedge'
end

every :monday, :at => '01:00' do
  rake 'new_report_ipranazteca'
end

every :monday, :at => '01:30' do
  rake 'new_report_mpr'
end

every :monday, :at => '02:00' do
  rake 'new_report_preagg'
end

every :monday, :at => '02:30' do
  rake 'new_report_google'
end

every :monday, :at => '03:00' do
  rake 'new_report_facebook'
end

every :monday, :at => '03:30' do
  rake 'new_report_netflix'
end

every :monday, :at => '04:00' do
  rake 'new_report_akamai'
end

every :monday, :at => '04:30' do
  rake 'new_report_core_mobile'
end

every :day, :at => '03:00' do
  rake 'new_session_manager_accedian'
end

every :day, :at => '05:00' do
  rake 'restart_session_accedian'
end

every :day, :at => '07:00' do
  rake 'reload_session_accedian'
end

every :saturday, :at => '06:51' do
  rake 'delete_objects_accedian'
end
