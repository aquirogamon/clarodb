# file: lib/tasks/prueba.rake

desc 'new report internet'
task new_report_internet: :environment do
  # ... set options if any
  InternetInterface.create(InternetInterface.statsinterfacecrecimiento_table)
end
