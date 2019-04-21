# file: lib/tasks/prueba.rake

desc 'new report mpr'
task new_report_mpr: :environment do
  # ... set options if any
  Samutilizationmwinterface.create(:samutilizationmwinterfaces_array => Samutilizationmwinterface.statsinterface_table)
end
