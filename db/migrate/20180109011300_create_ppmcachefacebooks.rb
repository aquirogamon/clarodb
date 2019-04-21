class CreatePpmcachefacebooks < ActiveRecord::Migration
  def change
    create_table :ppmcachefacebooks do |t|
      t.text :ppmcachefacebooks_array

      t.timestamps null: false
    end
  end
end
