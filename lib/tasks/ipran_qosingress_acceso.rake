# file: lib/tasks/prueba.rake

desc 'new report ipran qos ingress acceso'
task new_report_ipranqosingressacceso: :environment do
  # ... set options if any
  Samqos7705ingressdiscard.create(:samqos7705ingressdiscards_array => Samqos7705ingressdiscard.samqos7705ingressdiscard_table)
end
