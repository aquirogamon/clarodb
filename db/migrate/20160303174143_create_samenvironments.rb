class CreateSamenvironments < ActiveRecord::Migration
  def change
    create_table :samenvironments do |t|
      t.text :samenvironments_array

      t.timestamps null: false
    end
  end
end
