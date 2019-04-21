class CreateSaminterfacediscards < ActiveRecord::Migration
  def change
    create_table :saminterfacediscards do |t|
      t.text :saminterfacediscards_array

      t.timestamps null: false
    end
  end
end
