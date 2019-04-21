class CreatePpminterfaceinternets < ActiveRecord::Migration
  def change
    create_table :ppminterfaceinternets do |t|
      t.text :ppminterfaceinternets_array

      t.timestamps null: false
    end
  end
end
