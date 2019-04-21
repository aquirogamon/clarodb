desc 'restart session accedian manager'
task delete_objects_accedian: :environment do
  # ... set options if any
  SessionAccedian.delete_all_object_to_group
end
