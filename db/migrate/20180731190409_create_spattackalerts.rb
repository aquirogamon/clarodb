class CreateSpattackalerts < ActiveRecord::Migration
  def change
    create_table :spattackalerts do |t|
      t.text :spattackalerts_array

      t.timestamps null: false
    end
  end
end
