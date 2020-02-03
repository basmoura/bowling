class CreateLanes < ActiveRecord::Migration[5.2]
  def change
    create_table :lanes do |t|
      t.integer :status
      t.integer :bowling_house_id

      t.timestamps
    end
  end
end
