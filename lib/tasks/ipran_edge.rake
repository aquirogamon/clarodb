# file: lib/tasks/prueba.rake

desc 'new report ipran edge'
task new_report_ipranedge: :environment do
  # ... set options if any
  IpranedgeInterface.create(IpranedgeInterface.statsinterfacecrecimiento_table)
end