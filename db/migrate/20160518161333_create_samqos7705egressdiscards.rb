class CreateSamqos7705egressdiscards < ActiveRecord::Migration
  def change
    create_table :samqos7705egressdiscards do |t|
      t.text :samqos7705egressdiscards_array

      t.timestamps null: false
    end
  end
end
