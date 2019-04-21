# file: lib/tasks/prueba.rake

desc 'new report akamai'
task new_report_akamai: :environment do
  # ... set options if any
  CacheakamaiInterface.create(CacheakamaiInterface.statsinterfacecrecimiento_table)
end
