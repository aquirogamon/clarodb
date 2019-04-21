class CreateSamgilatinterfaces < ActiveRecord::Migration
  def change
    create_table :samgilatinterfaces do |t|
      t.text :samgilatinterfaces_array

      t.timestamps null: false
    end
  end
end
