# file: lib/tasks/prueba.rake

desc 'new report netflix'
task new_report_netflix: :environment do
  # ... set options if any
  CachenetflixInterface.create(CachenetflixInterface.statsinterfacecrecimiento_table)
end
