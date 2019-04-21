class CreateSamrouteldps < ActiveRecord::Migration
  def change
    create_table :samrouteldps do |t|
      t.text :samrouteldps_array

      t.timestamps null: false
    end
  end
end
