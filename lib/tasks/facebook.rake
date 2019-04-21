#file: lib/tasks/prueba.rake
#
desc 'new report facebook'
task new_report_facebook: :environment do
  # ... set options if any
    CachefacebookInterface.create(CachefacebookInterface.statsinterfacecrecimiento_table)
end
