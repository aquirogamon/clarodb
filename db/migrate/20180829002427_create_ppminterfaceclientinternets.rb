class CreatePpminterfaceclientinternets < ActiveRecord::Migration
  def change
    create_table :ppminterfaceclientinternets do |t|
      t.text :ppminterfaceclientinternets_array

      t.timestamps null: false
    end
  end
end
