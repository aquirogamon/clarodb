class CreateIpranaccessInterfaces < ActiveRecord::Migration
  def change
    create_table :ipranaccess_interfaces do |t|
      t.string :device
      t.string :port
      t.string :description
      t.float :egressRate
      t.string :speed
      t.float :gbpsrx
      t.float :gbpstx
      t.float :last_bps_max
      t.float :last_status
      t.float :bps_max
      t.float :status
      t.float :crecimiento
      t.date :time
      t.text :comment
      t.string :deviceindex

      t.timestamps null: false
    end
  end
end
