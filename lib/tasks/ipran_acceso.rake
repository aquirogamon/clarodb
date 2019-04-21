# file: lib/tasks/prueba.rake

desc 'new report ipran acceso'
task new_report_ipranacceso: :environment do
  # ... set options if any
  IpranaccessInterface.create(IpranaccessInterface.statsinterfacecrecimiento_table)
end
