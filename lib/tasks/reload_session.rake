desc 'reload session accedian manager'
task reload_session_accedian: :environment do
  # ... set options if any
  SessionAccedian.reload_waiting_session
  SessionAccedian.reload_error_session
end
