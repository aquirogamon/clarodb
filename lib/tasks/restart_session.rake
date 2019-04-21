desc 'restart session accedian manager'
task restart_session_accedian: :environment do
  # ... set options if any
  SessionAccedian.restart_waiting_session
  SessionAccedian.restart_error_session
end
