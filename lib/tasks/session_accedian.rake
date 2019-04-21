desc 'new session accedian manager'
task new_session_manager_accedian: :environment do
  # ... set options if any
  SessionAccedian.create(SessionAccedian.all_sessions_detail)
end
