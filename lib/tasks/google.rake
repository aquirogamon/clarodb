# file: lib/tasks/prueba.rake

desc 'new report google'
task new_report_google: :environment do
  # ... set options if any
  CachegoogleInterface.create(CachegoogleInterface.statsinterfacecrecimiento_table)
end
