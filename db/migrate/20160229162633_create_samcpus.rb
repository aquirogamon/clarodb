class CreateSamcpus < ActiveRecord::Migration
  def change
    create_table :samcpus do |t|
      t.text :samcpus_array

      t.timestamps null: false
    end
  end
end
