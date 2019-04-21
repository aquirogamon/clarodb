class CreatePpmcachenetflixes < ActiveRecord::Migration
  def change
    create_table :ppmcachenetflixes do |t|
      t.text :ppmcachenetflixs_array

      t.timestamps null: false
    end
  end
end
