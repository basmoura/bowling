class CreateBowlingHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :bowling_houses do |t|
      t.string :name
      t.integer :admin_id

      t.timestamps
    end
  end
end
