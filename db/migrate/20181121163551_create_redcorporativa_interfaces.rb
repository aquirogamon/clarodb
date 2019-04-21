class CreateRedcorporativaInterfaces < ActiveRecord::Migration
  def change
    create_table :redcorporativa_interfaces do |t|
      t.string :device
      t.string :port
      t.string :servicio
      t.float :gbpsrx
      t.float :gbpstx
      t.float :bps_max
      t.float :status
      t.float :last_bps_max
      t.float :last_status
      t.float :crecimiento_rx
      t.float :crecimiento_tx
      t.float :egressRate
      t.date :time
      t.text :comment
      t.string :deviceindex

      t.timestamps null: false
    end
  end
end
