class CreateFrames < ActiveRecord::Migration[5.2]
  def change
    create_table :frames do |t|
      t.integer :first_pins_dropped
      t.integer :second_pins_dropped
      t.integer :third_pins_dropped
      t.boolean :strike, default: false
      t.boolean :spare, default: false
      t.integer :points
      t.integer :status
      t.integer :game_id
      t.integer :user_id

      t.timestamps
    end
  end
end
