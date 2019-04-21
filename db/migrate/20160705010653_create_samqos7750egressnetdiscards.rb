class CreateSamqos7750egressnetdiscards < ActiveRecord::Migration
  def change
    create_table :samqos7750egressnetdiscards do |t|
      t.text :samqos7750egressnetdiscards_array

      t.timestamps null: false
    end
  end
end
