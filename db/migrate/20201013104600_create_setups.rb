class CreateSetups < ActiveRecord::Migration[5.2]
  def change
    create_table :setups do |t|
      t.integer :columns
      t.integer :rows
      t.integer :user_id
    end
  end
end