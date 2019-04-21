class CreatePpminterfacepreaggs < ActiveRecord::Migration
  def change
    create_table :ppminterfacepreaggs do |t|
      t.text :ppminterfacepreaggs_array

      t.timestamps null: false
    end
  end
end
