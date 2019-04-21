# file: lib/tasks/prueba.rake

desc 'new report ipran gilat'
task new_report_iprangilat: :environment do
  # ... set options if any
  Samgilatinterface.create(:samgilatinterfaces_array => Samgilatinterface.statsinterface_table)
end
