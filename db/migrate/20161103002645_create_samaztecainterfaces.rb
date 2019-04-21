class CreateSamaztecainterfaces < ActiveRecord::Migration
  def change
    create_table :samaztecainterfaces do |t|
      t.text :samaztecainterfaces_array

      t.timestamps null: false
    end
  end
end
