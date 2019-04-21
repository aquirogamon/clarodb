class CreatePpmpacketcores < ActiveRecord::Migration
  def change
    create_table :ppmpacketcores do |t|
      t.text :ppmpacketcores_array

      t.timestamps null: false
    end
  end
end
