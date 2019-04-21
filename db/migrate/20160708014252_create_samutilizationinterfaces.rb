class CreateSamutilizationinterfaces < ActiveRecord::Migration
  def change
    create_table :samutilizationinterfaces do |t|
      t.text :samutilizationinterfaces_array

      t.timestamps null: false
    end
  end
end
