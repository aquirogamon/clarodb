class CreateSaminternexainterfaces < ActiveRecord::Migration
  def change
    create_table :saminternexainterfaces do |t|
      t.text :saminternexainterfaces_array

      t.timestamps null: false
    end
  end
end
