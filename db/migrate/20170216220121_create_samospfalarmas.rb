class CreateSamospfalarmas < ActiveRecord::Migration
  def change
    create_table :samospfalarmas do |t|
      t.text :samospfalarmas_array

      t.timestamps null: false
    end
  end
end
