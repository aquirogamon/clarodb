class CreateSamroutevprns < ActiveRecord::Migration
  def change
    create_table :samroutevprns do |t|
      t.text :samroutevprns_array

      t.timestamps null: false
    end
  end
end
