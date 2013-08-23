class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.references :user
      t.references :puzzle
      t.integer :difficulty
      t.integer :quality

      t.timestamps
    end
    add_index :feedbacks, :user_id
    add_index :feedbacks, :puzzle_id
  end
end
