# file: lib/tasks/prueba.rake

desc 'new report ipran internexa'
task new_report_ipraninternexa: :environment do
  # ... set options if any
  Saminternexainterface.create(:saminternexainterfaces_array => Saminternexainterface.statsinterface_table)
end
