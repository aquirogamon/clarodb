# file: lib/tasks/prueba.rake

desc 'new report ipran qos egress acceso'
task new_report_ipranqosegressacceso: :environment do
  # ... set options if any
  Samqos7705egressdiscard.create(:samqos7705egressdiscards_array => Samqos7705egressdiscard.samqos7705egressdiscard_table)
end
