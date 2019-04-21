# file: lib/tasks/prueba.rake

desc 'new report core mobile'
task new_report_core_mobile: :environment do
  # ... set options if any
  Ppmpacketcore.create(:ppmpacketcores_array => Ppmpacketcore.statsinterfacemax_table)
end
