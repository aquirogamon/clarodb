class CreatePpmcachegoogles < ActiveRecord::Migration
  def change
    create_table :ppmcachegoogles do |t|
      t.text :ppmcachegoogles_array

      t.timestamps null: false
    end
  end
end
