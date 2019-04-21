class CreateSamutilizationaccesointerfaces < ActiveRecord::Migration
  def change
    create_table :samutilizationaccesointerfaces do |t|
      t.text :samutilizationaccesointerfaces_array

      t.timestamps null: false
    end
  end
end
