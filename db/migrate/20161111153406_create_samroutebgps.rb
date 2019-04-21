class CreateSamroutebgps < ActiveRecord::Migration
  def change
    create_table :samroutebgps do |t|
      t.text :samroutebgps_array

      t.timestamps null: false
    end
  end
end
