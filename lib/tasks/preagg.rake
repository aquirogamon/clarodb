# file: lib/tasks/prueba.rake

desc 'new report preagg'
task new_report_preagg: :environment do
  # ... set options if any
  PreaggInterface.create(PreaggInterface.statsinterfacecrecimiento_table)
end