class CreatePpmredcorporativainterfaces < ActiveRecord::Migration
  def change
    create_table :ppmredcorporativainterfaces do |t|
      t.text :ppmredcorporativainterfaces_array

      t.timestamps null: false
    end
  end
end
