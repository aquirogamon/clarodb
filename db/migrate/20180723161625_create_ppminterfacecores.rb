class CreatePpminterfacecores < ActiveRecord::Migration
  def change
    create_table :ppminterfacecores do |t|
      t.text :ppminterfacecores_array

      t.timestamps null: false
    end
  end
end
