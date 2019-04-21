class CreatePpmcacheakamais < ActiveRecord::Migration
  def change
    create_table :ppmcacheakamais do |t|
      t.text :ppmcacheakamais_array

      t.timestamps null: false
    end
  end
end
