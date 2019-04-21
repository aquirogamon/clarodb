class CreateSamqos7750egressdiscards < ActiveRecord::Migration
  def change
    create_table :samqos7750egressdiscards do |t|
      t.text :samqos7750egressdiscards_array

      t.timestamps null: false
    end
  end
end
