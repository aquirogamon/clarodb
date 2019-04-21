# file: lib/tasks/prueba.rake

desc 'new report ipran azteca'
task new_report_ipranazteca: :environment do
  # ... set options if any
  Samaztecainterface.create(:samaztecainterfaces_array => Samaztecainterface.statsinterface_table)
end
