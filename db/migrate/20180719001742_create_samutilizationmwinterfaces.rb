class CreateSamutilizationmwinterfaces < ActiveRecord::Migration
  def change
    create_table :samutilizationmwinterfaces do |t|
      t.text :samutilizationmwinterfaces_array

      t.timestamps null: false
    end
  end
end
