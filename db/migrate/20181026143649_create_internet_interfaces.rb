class CreateInternetInterfaces < ActiveRecord::Migration
  def change
    create_table :internet_interfaces do |t|
      t.string :device
      t.string :port
      t.string :servicio
      t.float :gbpsrx
      t.float :gbpstx
      t.float :bps_max
      t.float :last_bps_max
      t.float :last_status
      t.float :crecimiento
      t.float :status
      t.float :egressRate
      t.string :neighbor
      t.date :time
      t.text :comment
      t.string :deviceindex

      t.timestamps null: false
    end
  end
end
