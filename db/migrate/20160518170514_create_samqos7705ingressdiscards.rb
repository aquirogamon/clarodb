class CreateSamqos7705ingressdiscards < ActiveRecord::Migration
  def change
    create_table :samqos7705ingressdiscards do |t|
      t.text :samqos7705ingressdiscards_array

      t.timestamps null: false
    end
  end
end
