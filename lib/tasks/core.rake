# file: lib/tasks/prueba.rake

desc 'new report core'
task new_report_core: :environment do
  # ... set options if any
  CoreInterface.create(CoreInterface.statsinterfacecrecimiento_table)
end
