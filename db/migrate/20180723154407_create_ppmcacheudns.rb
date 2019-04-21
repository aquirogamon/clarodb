class CreatePpmcacheudns < ActiveRecord::Migration
  def change
    create_table :ppmcacheudns do |t|
      t.text :ppmcacheudns_array

      t.timestamps null: false
    end
  end
end
