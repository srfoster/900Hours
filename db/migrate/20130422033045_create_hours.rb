class CreateHours < ActiveRecord::Migration
  def change
    create_table :hours do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
