class CreateSamstatusports < ActiveRecord::Migration
  def change
    create_table :samstatusports do |t|
      t.text :samstatusports_array

      t.timestamps null: false
    end
  end
end
