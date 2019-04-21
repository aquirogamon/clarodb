class CreateSamrouteospfs < ActiveRecord::Migration
  def change
    create_table :samrouteospfs do |t|
      t.text :samrouteospfs_array

      t.timestamps null: false
    end
  end
end
