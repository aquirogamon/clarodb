class CreateSammemos < ActiveRecord::Migration
  def change
    create_table :sammemos do |t|
      t.text :sammemos_array

      t.timestamps null: false
    end
  end
end
