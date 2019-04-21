# file: lib/tasks/prueba.rake

desc 'new report internet'
task prueba: :environment do
  # ... set options if any
  Ppminterface.create(:ppminterfaces_array => Ppminterface.interface_table_internet("internet"))
end