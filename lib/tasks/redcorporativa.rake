# file: lib/tasks/prueba.rake

desc 'new report red corporativa'
task new_report_redcorporativa: :environment do
  # ... set options if any
  RedcorporativaInterface.create(RedcorporativaInterface.statsinterfacecrecimiento_table)
end
